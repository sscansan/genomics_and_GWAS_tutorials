# installation of plinkr, the r package for running plink in r.
# https://github.com/AJResearchGroup/plinkr
#
# alternatively you could run pling as system file.

library(remotes)
install_github("richelbilderbeek/plinkr")
remotes::install_github("chrchang/plink-ng/2.0/pgenlibr")

library(plinkr)
install_plinks()

get_plink_versions()

# you can choose which version of plink to use
run_plink("--help")
run_plink(c("--help", "--noweb"), create_plink_v1_7_options())
run_plink("--help", create_plink_v1_9_options())
run_plink("--help", create_plink_v2_0_options())


# GENETIC ASSOCIATION
plink_v1_9 <- create_plink_v1_9_options()
ped_filename <- get_plink_example_filename("toy.ped", plink_v1_9)
map_filename <- get_plink_example_filename("toy.map", plink_v1_9)

# Do a case-control association
plinkr::run_plink(
    args = c(
        "--ped", ped_filename,
        "--map", map_filename
    )
)

## Minimal example: show the PLINK help
if (is_plink_installed(create_plink_v1_7_options())) {
  # Without '--noweb', plinkr freezes with PLINK v1.7
  run_plink(
    args = c("--help", "--noweb"),
    create_plink_v1_7_options()
  )
}

if (is_plink_installed(create_plink_v1_9_options())) {
  run_plink("--help", create_plink_v1_9_options())
}

if (is_plink_installed(create_plink_v2_0_options())) {
  run_plink("--help", create_plink_v2_0_options())
}

# Do a case-control association
# Note: using 'plinkr::assoc' is safer, easier and has a uniform
# interface accross PLINK versions
plink_options <- create_plink_v1_9_options()
if (is_plink_installed(plink_options)) {
  # Use the PLINK v1.9 example files
  ped_filename <- get_plink_example_filename(
    "toy.ped", plink_options
  )
  map_filename <- get_plink_example_filename(
    "toy.map", plink_options
  )

  run_plink(
    args = c(
      "--ped", ped_filename,
      "--map", map_filename
    ),
    plink_options
  )

  # Delete the created files
  file.remove("plink.bed")
  file.remove("plink.fam")
  file.remove("plink.log")
}

# https://github.com/AJResearchGroup/plinkr
###   - See the vignette basic_usage for basic usage of PLINK, as taken from the PLINK website, which shows a quantitative trait - analysis
###  - See the vignette test_assoc_qt for the same basic usage of PLINK, using the plinkr interface
###   - See the vignette demo_assoc_qt for doing a quantitative trait analysis using simulated data and the plinkr interface

# Run a quantitative trait analysis on existing files
## Read from PLINK text files

assoc_qt_data <- create_assoc_qt_data(
  data = create_plink_text_filenames(
    map_filename = get_plinkr_filename("demo_assoc_qt.map"), 
    ped_filename = get_plinkr_filename("demo_assoc_qt.ped")
  ),
  phenotype_data = create_phenotype_data_filename(
    phe_filename = get_plinkr_filename("demo_assoc_qt.phe")  
  )
)
assoc_qt_filenames <- assoc_qt(assoc_qt_data = assoc_qt_data)
read_plink_qassoc_file(assoc_qt_filenames$qassoc_filenames[1])

Read from PLINK binary files

assoc_qt_data <- create_assoc_qt_data(
  data = create_plink_bin_filenames(
    bed_filename = get_plinkr_filename("demo_assoc_qt.bed"), 
    bim_filename = get_plinkr_filename("demo_assoc_qt.bim"), 
    fam_filename = get_plinkr_filename("demo_assoc_qt.fam")
  ),
  phenotype_data = create_phenotype_data_filename(
    phe_filename = get_plinkr_filename("demo_assoc_qt.phe")  
  )
)
assoc_qt_filenames <- assoc_qt(assoc_qt_data = assoc_qt_data)
read_plink_qassoc_file(assoc_qt_filenames$qassoc_filenames[1])