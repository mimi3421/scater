Please refer to the official README in https://github.com/davismcc/scater .

This is a temporarily patched version of SCATER(201907300).
The only edited place of this version is the R version required changing from 3.6 to 3.5 in DESCRIPTION file.

Follow these steps to install batchelor(fastMNN) under R3.5 (Linux) if you just want to have a try (NOT FULLY TESTED).

``` R
# R script

# Install Rhdf5lib
BiocManager::install("Rhdf5lib")
# or devtools::install_github("grimbough/Rhdf5lib")

# Add include path for compile
Sys.setenv("PKG_CXXFLAGS"="-I[PATH_TO_R]/library/Rhdf5lib/include")
Sys.setenv("PKG_LIBS"="-L[PATH_TO_R]/library/Rhdf5lib/lib")

# install packages from sources
devtools::install_github("LTLA/beachmat")
devtools::install_github("LTLA/BiocSingular")
#devtools::install_github("davismcc/scater")
devtools::install_github("mimi3421/scater")
devtools::install_github("LTLA/BiocNeighbors")
devtools::install_github("LTLA/batchelor")

```
