# ULL_R_course

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

This repository contains the R scripts and RMarkdown files used to teach in my 04-06/05/2022 R course at IUBO, University of La Laguna. 

## Prerequisites

Working installations of [R](https://cran.rstudio.com/) (3.6 or higher) and [RStudio]( https://www.rstudio.com/products/rstudio/download/#download) (1.2 or higher). 

For the RMarkdown files to knit correctly, installations of Microsoft Word and a LaTeX installation are also necessary. LaTeX can be most easily installed from RStudio via the tinytex package, as explained in the [tinytex instruction](https://yihui.org/tinytex/). 

## Course structure

### Day 1 - Introduction to R and RStudio

- Using the RStudio interface
- basic calculations in R
- logical statements
- using and naming variables
- clean working practices
- installing and loading packages
- data types (character, numeric, integer, complex, logical)
- data structures (vectors, matrices, data frames, lists)
- missing data
- simple data exploration
- subsetting
- reading and writing external data files
- working directories, absolute vs relative file paths
- working with RStudio projects
- getting help

### Day 2 - Data Manipulation and Visualization

#### Data Manipulation

- introduction to pipes and dplyr
- common transformations (filter, select, mutate, summarize)
- data joins
- using tidyr to change between long and wide data formats

#### Data Visualization

- R base plots vs ggplot2
- ggplot2 layer structure and mapping variables
- adding common geoms (points, lines, violins, boxplots)
- mapping to color, fill
- avoid overplotting using dodging and jittering
- barplots
- statistical summaries and transformations
- multiple facets
- visual choices to improve aesthetics and clarity of plots
- customizing plot themes
- custom color schemes
- exporting plots
- combining multiple plots

### Day 3 - Reproducible Manuscripts in RMarkdown

- Introduction to RMarkdown (advantages, use cases, functional principles)
- basic structure of RMarkdown documents
- markdown text formatting
- sections
- LaTeX syntax for equations and mathematical expressions
- code chunks
- adding plots using code chunks
- chunk options
- yaml header options
- inline R code
- adding tables
- changing between output formats (html, docx, pdf)
- making a pdf journal article manuscript using the rticles package
- auxilliary files (cls, bib, sty, spl, tex)
- basic layout changes using yaml options and latex syntax
- figure and table captions
- cross-referencing using latex syntax
- citations using bibtex
- maintaining clean workflows and repository structures
- intro to producing docx output
- formatting changes using style reference files
- custom styles using css syntax
- cross-referencing using pandoc syntax
- collaborations and RMarkdown workflows
