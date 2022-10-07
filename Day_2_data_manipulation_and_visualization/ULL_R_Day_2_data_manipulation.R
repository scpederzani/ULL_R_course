
#### housekeeping ####

# etherpad
# https://etherpad.wikimedia.org/p/ULL_R


# install packages:

install.packages(c("palmerpenguins", "ggplot2", "dplyr", "tidyr", "MetBrewer", 
                   "knitr", "tinytex", "rticles", "officedown", "flextable"))

tinytex::install_tinytex()

# have a project open
# project folder needs to have a folder called 'data'

# load penguin data

penguin_data <- read.csv(file = "data/penguins.csv")

# or make penguin data:

library(palmerpenguins)

penguin_data <- penguins

#### TASK ####

x <- c(5.4, 6.2, 7.1, 4.8, 7.5)
names(x) <- c('a', 'b', 'c', 'd', 'e')
print(x)
# Come up with at least 2 different commands that will produce the following output:

# b   c   d 
# 6.2 7.1 4.8

x[c("b", "c", "d")]
x[c(2:4)]
x[c(2, 3, 4)]
x[2:4]
x[-c(1,5)]
x[c(FALSE, TRUE, TRUE, TRUE, FALSE)]

#### combine list elements ####

# make a list of penguin data

penguin_list <- list(
  penguins_1 = head(penguins), 
  penguins_2 = tail(penguins)
)

#combine list elements

do.call(rbind, penguin_list)

# combine separate lists

penguin_list_1 <- list(head(penguins))

penguin_list_2 <- list(tail(penguins))

combined_list <- rbind(penguin_list_1, penguin_list_2) # makes list of lists

penguins_df <- do.call(rbind, c(penguin_list_1, penguin_list_2))

#### data manipulation ####
#with dplyr

#install.packages("dplyr")

library(dplyr)

head(penguin_data)

# dplyr is a package in a group of packages called the tidyverse
# collection of packages by the RStudio team that are specifically designed to be easy
# readable and convenient
# include a slightly different approach to syntax compared to base R

# lets calculate a mean to illustrate the differences

# base R syntax is like math, you read from the inside to the outside

mean(penguin_data$body_mass_g[penguin_data$island == "Torgersen"], na.rm = TRUE)

# this is very short, but really hard to read as a human

# tidyverse solution is written like a recipe with the %>% operator between steps

penguin_data %>%
  filter(island == "Torgersen") %>% # only penguins on Torgersen
  select(body_mass_g) %>% # select body mass
  summarize(torgersen_mean_body_mass = mean(body_mass_g, na.rm = TRUE)) # calculate mean

# deselect also with minus sign
# and filter with exlcusion using !

penguin_data %>%
  filter(!island == "Torgersen") %>%
  select(-species) %>%
  head()

# new columns using mutate

# calculations
penguin_data %>%
  mutate(bill_index = bill_length_mm/bill_depth_mm) %>%
  head(.) %>%
  as.data.frame(.)

# fill with a repeating value

penguin_data %>%
  mutate(project = "palmerpenguins") %>%
  head(.) %>%
  as.data.frame(.)

# summaries of our data according to groups

penguin_data %>%
  group_by(island) %>%
  summarize(mean_body_mass = mean(body_mass_g, na.rm = TRUE))

#Challenge: group by island and calculate the mean and standard deviation of body mass
#using functions mean() and sd() for each island

#A: 
  
penguin_data %>%
  group_by(island, species) %>%
  summarize(mean_body_mass = mean(body_mass_g, na.rm = TRUE), 
            sd_body_mass = sd(body_mass_g, na.rm = TRUE))


#### optional ####

# joining

# let's make to separate data sets and join them back together

unique(penguin_data$island) 

# or

penguin_data %>%
  select(island) %>%
  distinct()

archipelago <- data.frame(island = c("Biscoe", "Dream", "Torgersen"), 
                          archipelago = c("Biscoe Islands", "Palmer archipelago", 
                                          "Palmer archipelago"))

# join together

penguins_archipelago <- full_join(penguin_data, archipelago, by = "island")

View(penguins_archipelago)

#### tidyr ####

head(penguin_data)

penguins_long <- penguin_data %>%
  select(-bill_length_mm, -bill_depth_mm, -flipper_length_mm) %>%
  filter(island == "Dream") %>%
  group_by(year) %>%
  slice_sample(n = 5) %>%
  mutate(sex = "female") %>%
  mutate(individual = 1:5) %>%
  mutate(species = rep("Adelie", 5))
  ungroup()

penguins_long

# pivot wider

pivot_wider(penguins_long,  
            names_from = c(year), 
            values_from = body_mass_g)


pivot_wider(penguins_long,  
            names_from = c(year), 
            names_prefix = "body_mass_g_",
            values_from = body_mass_g)


penguins_wide <- pivot_wider(penguins_long,  
                             names_from = c(year), 
                             names_prefix = "body_mass_g_",
                             values_from = body_mass_g)

# pivot back to longer data

pivot_longer(penguins_wide, 
             cols = starts_with("body"),
             names_to = "year", 
             values_to = "body_mass_g")

pivot_longer(penguins_wide, 
             cols = starts_with("body"),
             names_to = "year", 
             names_prefix = "body_mass_g_",
             values_to = "body_mass_g")

#### SHOW CHEAT SHEETS ####

#### housekeeping ####

# install packages:

install.packages("ggplot2")
install.packages("MetBrewer")
install.packages("knitr")
install.packages("tinytex")
install.packages("rticles")
install.packages("officedown")
install.packages("flextable")

tinytex::install_tinytex()




