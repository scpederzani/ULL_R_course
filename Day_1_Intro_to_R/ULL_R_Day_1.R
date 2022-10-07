
# change my error language to english
Sys.setenv(LANG = "en")

# etherpad
# https://etherpad.wikimedia.org/p/ULL_R

#### Intro ####

#- why use R?
# - lazy! --> no repeating of button clicks
# - very good and efficient for data cleaning, statistics and visualization
# - reproducible, all steps are traceable, recorded and can be checked and repeated later

#### RStudio ####

# The RStudio interface - let's orient ourselves
# R exists independently, but RStudio makes using it much easier and has lots of nifty functions

# Default set up: 4 panels: console (calculator, not saved, shows output), environment (created variables and objects), 
# files/plot/help, script panel

# move and close panels

# let's open a script
# run script code using ctrl enter (cmd return on mac)

#### Math ####

# basic calculations
1 + 1
2 + 4
2 * 3


1 + 100
100 - 1 
2 * 2 
10 / 2
2^2

# use parantheses

(2 + 2) * 2

# compress syntax
5e3 # = 5 * 10 ^3

# logarithms, exponential

log(1)
log10(10)
sin(2)
exp(0.5) # = e^(1/2)
exp(1)^(1/2)

#### Logical ####

# compare things and receive true/false statements

# equal
1 == 1
1 == 2

# not equal
1 != 1
1 != 2

# larger, smaller
1 < 2
2 > 1

# larger or equal
1 >= -9

# should write with spaces to make things legible

#### variables, objects ####

# assign things to variables to save things into our environment for multi step operations

# <- is the R assignment operator
x <- 1/40

# return variables
x
# make calculations
log(x)

# update variable content, overwrites
x <- 12
x

x <- log(x) + 1 
x

# be careful not to accidentally overwrite things!
# it's best to give meaningful names to variables, not use random letters like here!

#### variable naming ####

# naming conventions

# snake case
mean_boys <- 30
# camelcase
meanBoys <- 30

# be consistent, this makes your code clean and tidy :)
# don't use periods to separate (will see this loads in old r code)
# will cause problems when porting to other languages where the period is an operator!!!
# best not to get used to it!

# what kind of variable names will or wont't work?

# does not work
_age <- 1
min-length <- 1
2widths <- 1

# hidden variable
.mass <- 1

# Valid variable names
MaxLength <- 1
celsius2kelvin <- 1
min_height <- 1
max.height <- 1 # don't use this!!!

# you can also use = sign to assign, but explain why I don't use anymore

x = 2
y <- 2

# spaces don't do anything!
# but is normally nice to use them properly for readability!
y <- 2
y<-2

#### vectorization ####

# variables can store multiple values!
# will talk about different forms of data types and objects later, but let's do the easiest firs: Vectors!

# values from 1 to 5
1:5
x <- 1:5
x

# or use the combine function

x <- c(2,4,6,8)
x

# operations are applied to all cells of the vector
2^x
2^(1:5)

#### Environment management ####

# check what's in your environment --> use panel, but also in console:

ls()

# removing variables from the environment

rm(x)

# remove all variables in the environment
rm ( list = ls() )

# or use the small broom of the panel

# clean working practices!
# always start with empty environment
# one of the most common source of mistakes happens if you still have stuff saved in the environment that isn't up
# to date!

# RStudio setting:
# don't save or restore workspace

# save the script not the environment!
# if you have computationally expensive stuff save it into files or objects and call those
# will teach how later

#### packages ####

# people develop neat functionalities for R that are not included in the base installation
# you will use packages all the time!

# let's install some:

install.packages("ggplot2")

# installs packages from CRAN, an official package repository where packages are heavily quality controlled

# need quotation marks to work, because R doesn't "know" the package yet
# packages then need to be loaded so you can access them

library(ggplot2)

# quotations no longer necessary, because R already knows this package
# see loaded packages in the packages tab

# always load all packages at the beginning of a script so it's easy to check what you will need for the script
# it's like a cooking recipe!

#### TASKS ####

###
# What will be the value of each variable after each statement in the following program?
mass <- 47.5
age <- 122
mass <- mass * 2.3
age <- age - 20

# Compare Mass and Age --> Check for inequality
mass != age


# Remove Objects mass and age from the environment
rm(age)
rm(mass)
# rm(mass, age) or use this

# Install "dplyr", "ggplot2" and "knitr"

install.packages("dplyr")
install.packages(c("ggplot2", "palmerpenguins"))

# Access packages 
library(dplyr)
library(ggplot2)
library(palmerpenguins)

### Data structures & types ####

# different ways of storing data
# some need all data to be the same type
# some are more flexible

#### data types ####

# let's learn about different types of data and how to use them in a vector

# data types : character, numeric (whole numbers), integer (real or decimal), complex (complex numbers, e.g. i), and logical (TRUE, FALSE)

# R provides tools to find out data types:

x <- "cats"

typeof(x)

y <- 1:5

typeof(y)

# coerce to different type:

z <- as.character(y)

as.numeric(z)

#### data structures ####

#### vectors ####

# basically a string of things of the same type

# numeric
number_vector <- c(1,2,3)

#character
letter_vector <- c("a", "b", "c")

# boolean
boolean_vector <- c(TRUE, FALSE, TRUE)

# can also make empty vectors of a certain type:

character(5)

# use rep to populate with same thing

zeroes_vector <- rep(0, 10)

# missing data

incomplete_vector <- c("a", "b", NA, "d")
incomplete_vector

# interrogate for missing data

anyNA(incomplete_vector) # contains any NA?
is.na(incomplete_vector) # which ones?

# can't have different things in vectors

mixed_vector <- c("a", "b", 3)

mixed_vector

typeof(mixed_vector)

# another useful function is length()

length(mixed_vector)

# str() gives info about data type and lengths

str(mixed_vector)

# number has been coerced into a character
# R won't tell you there is an error, it will instead force your data into something it can make a vector with
# be careful!

#### matrices ####

# essentially 2D vectors
# need to be homogenous

example_matrix <- matrix(data = 1:100, nrow = 5, ncol = 20)
example_matrix

# matrices are filled column wise!!!

# make row-wise like this:

row_matrix <- matrix(data = 1:100, nrow = 5, ncol = 20, byrow = TRUE)
row_matrix

# behave like vectors in calculations:

example_matrix * 2

# another useful tool for checking data structures is class

class(example_matrix) # tells you about structure
typeof(example_matrix) # tells you data type

# length of matrices gives number of elements

length(example_matrix)

# dimensions
# returns rows and columns

dim(example_matrix)

# str gives col, row info
str(example_matrix)


#### data frames ####

# normally we want to work with something that is a bit more 'table' like
# in R these things are called data frames

# let's make our own and save it

cats <- data.frame(coat = c("calico", "black", "tabby", "red", "grey", "striped", "white"),
                   weight = c(2.1, 5.0, 3.2, 2.4, 6.1, 3.4, 3.3),
                   likes_string = c(1, 0, 1, 1, 1, 0, 1))

# uses the c() function for each column
# --> dfs are basically a collection of named vectors with equal length

# can view dfs by clicking on it in the environment or use

View(cats)

# checking structures etc

str(cats)

class(cats)

head(cats) # first 6 rows
tail(cats) # last 6 rows

# for data frames length returns number of columns
length(cats)

#FACTORS for categorical data
# strings.as.factors
typeof(cats$coat)

#### lists ####

# data frames are actually a special case of lists where all list elements have the same length
# a rectangular list essentially

# lists are the most flexible data structure in R
# can contain a mix of any data types and structures
# list of data frames, list of vector, a df and a matrix, lists of lists
# often used as output of functions, not often used for human read data

# let's make a cat list

calico_cat <- list(coat = "calico", weight = 2.1, likes_string = 1)

# list of lists
cat_list <- list(
  list(
    coat = "calico", 
    weight = 2.1, 
    likes_string = 1
  ),
  list(
    coat = "black", 
    weight = 5.0, 
    likes_string = 0
  ))

str(cat_list)
# --> cat-oriented list

# list of df and list

het_list <- list(calico_cat, cats)

het_list

# or use names feature

het_list <- list(calico = calico_cat, cats_df = cats)

het_list


str(het_list)

#### working with files ####

# we need to reading and saving files
# let's make sure everything is clean

# make a folder for data and for scripts
# you can use the files panel!

# to save and load files we need to know 'where' R is on our computer
# --> working directory

getwd()

setwd("C:/Users/Sarah/My Drive/Work/08_teaching/2205_ULL_R_Course/scripts/ULL_R_course")

# don't use setwd in scripts!!!
# it doesn't transfer to other computers

# should be using portable, relative structure
# nifty solution for this is the project feature in RStudio

# make new project

getwd()

# working directory is automatically always the project directory
# we can use relative file paths now and just always copy the whole project 
# and it won't matter where its sitting

# get some data from the palmerpenguins package
# make a folder called data

penguin_data <- penguins

# write as csv
write.csv(penguin_data, file = "data/penguins.csv", row.names = FALSE)

# remove
rm(penguin_data)

# read a csv
penguin_data <- read.csv(file = "data/penguins.csv")

# pay attention to relative paths!
# show example of mistake with paths


#### Looking for Help ####

# R Help
?mean
?rm

help(mean)

# google things!
# stack overflow
# copy error messages into google with R in front


#### subsetting/indexing ####

# two different syntaxes for accessing object elements

# either using element "coordinates" or using names (e.g. column names or list names)

# names:

head(penguin_data)

# access column by name using dollar sign
# returns column in vector form

penguin_data$species

# using coordinate system

# for vectors just use the number of the element
# in R starts with 1 not 0!

penguin_data$species[3]

# or

species <- penguin_data$species

species[3]

# can also use for dfs and matrices
# use [row, column]

penguin_data[3,1]

# access all columns or all rows

# complete first column, all rows
penguin_data[,1]

# complete first row, all columns

penguin_data[1,]

# multiple rows

penguin_data[1:3,]

penguin_data[c(1,5), ]

#### manipulate elements ####

# change values using assignment operator

penguin_data$species[1] <- "Fantasy"

penguin_data

# change column names

colnames(penguin_data)

colnames(penguin_data)[1] <- "Taxon"

colnames(penguin_data)

# add elements together

# new columns

penguins_subset <- head(penguin_data)

age <- c(1,2,3,4,5,6)

penguins_age <- cbind(penguins_subset, age)

penguins_age

# new rows

new_penguin <- c("Adelie", "Torgersen", 20, 15, 180, 4000, "female", 2022)

updated_penguins <- rbind(penguins_subset, new_penguin)

updated_penguins

# remove elements

updated_penguins[-1,]

updated_penguins[,-3]

#### housekeeping ####

# install packages:

install.packages("dplyr")
install.packages("ggplot2")
install.packages("MetBrewer")
install.packages("knitr")
install.packages("tinytex")
install.packages("rticles")
install.packages("officedown")
install.packages("flextable")

tinytex::install_tinytex()


