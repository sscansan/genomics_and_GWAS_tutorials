# GWAS_project

## Genetic association of quantitative traits

GitHub repository of a bioinformatic Genome Wide Association Study project using
Plink through `plinkr` R package. For learning puropses other repositories,
scripts and sources have been used, taken or modified such as:

- PLINK 1.90 [https://www.cog-genomics.org/plink2/](https://www.cog-genomics.org/plink2/)
- `plinkr` R package repository documentation
  [https://github.com/AJResearchGroup/plinkr](https://github.com/AJResearchGroup/plinkr)

- **Marees AT**, de Kluiver H, Stringer S, et al. A tutorial on conducting
  genome-wide association studies: Quality control and statistical analysis.
  _Int J Methods Psychiatr Res_. 2018; 27:e1608.
  [https://doi.org/10.1002/mpr.1608](https://doi.org/10.1002/mpr.1608)
- **Marees et al.** (2018) tutorial
  [https://github.com/MareesAT/GWA_tutorial](https://github.com/MareesAT/GWA_tutorial)

- **Gábor Mészáros** (2021) Genomic Boot Camp Book
  [https://genomicsbootcamp.github.io/book/](https://genomicsbootcamp.github.io/book/)
- **Gábor Mészáros** video tutorials [https://www.youtube.com/c/GenomicsBootCamp](https://www.youtube.com/c/GenomicsBootCamp)

- **Naderi S**, Rezaei HR, Pompanon F, Blum MGB, Negrini R, Naghash HR, et al. (2008) The goat domestication process inferred from large-scale mitochondrial DNA analysis of wild and domestic individuals. *Proc Natl Acad Sci* USA. 105:17659–64.

- **Bertolini, F.**, Servin, B., Talenti, A. et al. Signatures of selection and environmental adaptation across the goat genome post-domestication. *Genet Sel Evol* 50, 57 (2018). [https://doi.org/10.1186/s12711-018-0421-y](https://doi.org/10.1186/s12711-018-0421-y)

- **Colli, L.**, Milanesi, M., Talenti, A. et al. Genome-wide SNP profiling of worldwide goat populations reveals strong partitioning of diversity and highlights post-domestication migration routes. *Genet Sel Evol* 50, 58 (2018). [https://doi.org/10.1186/s12711-018-0422-x](https://doi.org/10.1186/s12711-018-0422-x)
- **Colli et al.** (2020). Data from: Signatures of selection and environmental adaptation across the goat genome post-domestication [Dataset]. *Dryad*. [https://doi.org/10.5061/dryad.v8g21pt](https://doi.org/10.5061/dryad.v8g21pt)

- **Decker JE**, McKay SD, Rolf MM, Kim J, Molina Alcalá A, et al. (2014) Worldwide Patterns of Ancestry, Divergence, and Admixture in Domesticated Cattle. *PLOS Genetics* 10(3):
  e1004254.[https://doi.org/10.1371/journal.pgen.1004254](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1004254),
- **Decker et al.** (2015). Data from: Worldwide patterns of ancestry, divergence, and admixture in domesticated cattle [Dataset]. Dryad. [https://doi.org/10.5061/dryad.th092](https://doi.org/10.5061/dryad.th092)
  
---

### Get PLINK working in Linux

1.  Download [PLINK 1.90 Linux 64-bit](https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20231211.zip)
2.  Install PLINK
    ```
    cd Downloads/
    sudo unzip plink_linux_x86_64_20200616.zip -d plink_install
    ```
3.  PLINK in `usr/local/bin`

    ```
    cd plink_install
    sudo cp plink /usr/local/bin
    sudo chmod 755 /usr/local/bin/plink
    ```

4.  Add PLINK to PATH

    with Bourne-Again SHell
    ```
    sudo nano ~/.bashrc
    ```

    or with zsh

    ```
    sudo nano ~/.zshrc
    ```

    then

    ```
    export PATH=/usr/local/bin:$PATH
    ```

    Save and exit, you should be able to call `plink` from the terminal at any user
    position in the system

    ```
    plink --help
    ```
---
### Licenses
Data obtained from tghe DRYAD repository are licensed with a  CC0 1.0 Universal (CC0 1.0) Public Domain Dedication license. 
"
    The person who associated a work with this deed has dedicated the work to the public domain by waiving all of his or her rights to the work worldwide under copyright law, including all related and neighboring rights, to the extent allowed by law.
    You can copy, modify, distribute and perform the work, even for commercial purposes, all without asking permission.
"

As such, also this repository, which is a collection of various resources, and own code or ideas, is licensed with a CC0 1.0 License.
