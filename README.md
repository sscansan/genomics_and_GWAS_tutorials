# GWAS_project

## Genetic association of quantitative traits

GitHub repository of a bioinformatic Genome Wide Association Study project using
Plink through `plinkr` R package. For learning puropses other repositories,
scripts and sources have been used, taken or modified such as:

- `plinkr` R package repository documentation
  [https://github.com/AJResearchGroup/plinkr](https://github.com/AJResearchGroup/plinkr)
- **Marees AT**, de Kluiver H, Stringer S, et al. A tutorial on conducting
  genome-wide association studies: Quality control and statistical analysis.
  _Int J Methods Psychiatr Res_. 2018; 27:e1608.
  [https://doi.org/10.1002/mpr.1608](https://doi.org/10.1002/mpr.1608)
- _Marees et al. (2018) tutorial_
  [https://github.com/MareesAT/GWA_tutorial](https://github.com/MareesAT/GWA_tutorial)
- **Gábor Mészáros** (2021) Genomic Bootcamp Book
  [https://genomicsbootcamp.github.io/book/](https://genomicsbootcamp.github.io/book/)
- **Naderi S**, Rezaei HR, Pompanon F, Blum MGB, Negrini R, Naghash HR, et al. *The
  goat domestication process inferred from large-scale mitochondrial DNA
  analysis of wild and domestic individuals*. Proc Natl Acad Sci USA.
  2008;105:17659–64.
  [https://gsejournal.biomedcentral.com/articles/10.1186/s12711-018-0421-y](https://gsejournal.biomedcentral.com/articles/10.1186/s12711-018-0421-y),
  and data:
  [https://datadryad.org/stash/dataset/doi:10.5061/dryad.v8g21pt](https://datadryad.org/stash/dataset/doi:10.5061/dryad.v8g21pt)
- **Decker JE**, McKay SD, Rolf MM, Kim J, Molina Alcalá A, et al. (2014) *Worldwide
  Patterns of Ancestry, Divergence, and Admixture in Domesticated Cattle*. PLOS
  Genetics 10(3):
  e1004254.[https://doi.org/10.1371/journal.pgen.1004254](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1004254),
  and data:
  [https://datadryad.org/stash/dataset/doi:10.5061/dryad.th092](https://datadryad.org/stash/dataset/doi:10.5061/dryad.th092)

---

### Get PLINK working in Linux

1.  Download PLINK v.1.9 [Linux 64-bit] from
    [https://www.cog-genomics.org/plink/](https://www.cog-genomics.org/plink/)
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

    ```
    sudo nano ~/.bashrc
    ```

    or

    ```
    sudo nano ~/.zshrc
    ```

    then

    ```
    export PATH=/usr/local/bin:$PATH
    ```

Save and exit, you should be able to call `plink` from the terminal at any user
position in the system.
