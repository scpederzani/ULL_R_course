
install.packages("ggplot2")
install.packages("dplyr")
install.packages("palmerpenguins")

library(dplyr)
library(ggplot2)
library(palmerpenguins)

head(penguins)

# let's exclude missing data

penguins_narm <- penguins %>%
  filter(!is.na(sex))

write.csv(penguins_narm, file = "data/penguins_no_na.csv", row.names = FALSE)

# you can also plot in base R
# its easy for simple plots
# its faster if you are generating many plots automatically
# kinda clunky syntax and is harder to make look nice

plot(penguins$flipper_length_mm, penguins$body_mass_g)

ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()
# call first the ggplot function
# you tell ggplot what data you are working with
# mapping --> uses the aes() function = 'aesthetics'
# this here includes the variables for the coordinates
# you don't have to use correct R subsetting here, as ggplot already knows
# to look in 'data' --> only use column names

### the base layer of coordinates and data

ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g))

# this draws up a grid of our coordinates, but does not plot data
# because we have no geoms, which are responsible for data plotting

# so we re-add the points

ggplot(data = penguins, mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()

#### Challenge 1 ####

# modify the example to show differences in body mass between islands

ggplot(data = penguins, mapping = aes(x = island, y = flipper_length_mm)) + 
  geom_point()

# one solution:

ggplot(data = penguins, mapping = aes(x = island, y = body_mass_g)) + 
  geom_point()

#### Challenge 2 ####

# we used aes() so far for coordinates
# we can also use the aesthetic 'color'
# Q: modify the code to color by sex


# Solution:

ggplot(data = penguins, mapping = aes(x = island, y = body_mass_g, color = sex)) + 
  geom_point()


# hard to see group distributions in a scatter plot
# --> let's make a summarizing plot using violin plots

# you can leave out data and mapping


ggplot(penguins, aes(x = island, y = body_mass_g, color = sex)) + 
  geom_violin()

# box plot would be like this:

ggplot(penguins, aes(x = island, y = body_mass_g, color = sex)) + 
  geom_boxplot()

# add points back on top

ggplot(penguins_narm, aes(x = island, y = body_mass_g, color = sex)) + 
  geom_violin()+
  geom_point()

# are not aligned with violins

ggplot(penguins_narm, aes(x = island, y = body_mass_g, color = sex)) + 
  geom_violin(position = position_dodge(width = 1))+
  geom_point(position = position_dodge(width = 1))

# note order of layers influences printing order!

#### inheriting aes() ####

# note that aes() and other arguments in ggplot are inherited for the
# underlying layers unless overwritten
# so here I moved the color aes to the geom_line only, so that 
# geom_point doesn't inherit the color and just turns black

# also note that you don't have to write out mapping and data everytime
# ggplot will reckognize also this

ggplot(penguins_narm, aes(x = island, y = body_mass_g)) + 
  geom_violin(aes(color = sex), position = position_dodge(width = 1))+
  geom_point(position = position_dodge(width = 1))

# groupings also gone, because ggplot was inferring different groups from the colors

ggplot(penguins_narm, aes(x = island, y = body_mass_g, color = sex)) + 
  geom_violin(position = position_dodge(width = 1))+
  geom_point(position = position_dodge(width = 1))

#### aes values instead of mapping ####

# this doesnt work:

ggplot(penguins_narm, aes(x = island, y = body_mass_g, color = "blue")) + 
  geom_violin(position = position_dodge(width = 1))+
  geom_point(position = position_dodge(width = 1))

# because aes expects some kind of groups to map colors to
# if you are setting just one value you move this outside the aes function

ggplot(penguins_narm, aes(x = island, y = body_mass_g, color = sex)) + 
  geom_violin(position = position_dodge(width = 1))+
  geom_point(position = position_dodge(width = 1), color = "black", aes(group = sex))

#### Challenge 3 ####

#Q: what happens if you switch the order of the points and violins?
#A: the violins get plotted on top


ggplot(penguins_narm, aes(x = island, y = body_mass_g, color = sex)) +
  geom_point(position = position_dodge(width = 1), color = "black", aes(group = sex))+
  geom_violin(position = position_dodge(width = 1))
  
## TIP
# the last line can't have a + at the end, otherwise ggplot will 
# add whatever you run next to its plot
# this can be really annoying of youre wanting to change the order of things

# you can use:
ggplot(penguins_narm, aes(x = island, y = body_mass_g, color = sex)) + 
  geom_violin(position = position_dodge(width = 1))+
  geom_point(position = position_dodge(width = 1))+
  NULL
# to always have a fixed endpoint and shuffle your lines around
# without adding and removing plusses all the time

# fill, transparency, jitter
# try to avoid overplotting and make things look nice

ggplot(penguins_narm, aes(x = island, y = body_mass_g, fill = sex)) + 
  geom_violin(position = position_dodge(width = 1), alpha = 0.5, color = NA)+
  geom_point(color = "black", shape = 21, 
             position = position_jitterdodge(dodge.width = 1, jitter.width = 0.2))+
  NULL

# let's make a barplot of proportion of different species per island

ggplot(penguins_narm, aes(x = island, color = species, fill = species))+
  geom_bar(aes(group = species))

# default is a stacked barplot
# side by side barplots

ggplot(penguins_narm, aes(x = island, color = species, fill = species))+
  geom_bar(aes(group = species), position = position_dodge(width = 1))


#### transformations and stats ####

# ggplot can also add visualizations for statistics, or let you
# directly transform data to be plotted a certain way

#### fit a linear model and plot it ####

# lets plot again flipper length agains body mass

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

# add a linear regression line

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()+
  geom_smooth(method = "lm")# method 'linear model'


# change the visual of the linear model

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()+
  geom_smooth(method = "lm", size = 1.5)# size controls line thickness of lm

#### Challenge 4 ####

#Q: modify color, size and fill of points and linear model

#A:

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(size = 3, color = "navy")+
  geom_smooth(method = "lm", size = 1, 
              color = "slateblue", fill = "slateblue", alpha = 0.5)


# Q: use the color to introduce groups again, like the species
# and use a different shape

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g, 
                          color = species, 
                          fill = species)) + 
  geom_point(size = 3)+
  geom_smooth(method = "lm", size = 1, alpha = 0.5)

# note that introducing mapping groups will automatically
# make geom_smooth inherit these groups and make multiple trendlines

# what would you to to avoid this???

#A: put color into points, not ggplot call

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(size = 3, aes(color = species))+
  geom_smooth(method = "lm", size = 1, alpha = 0.5)

#### multiple panels ####

# if your plot is very crowded with different aspects, you can make panels
# f ex we can make panels for male and female penguins


ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(size = 3)+
  facet_wrap( ~ sex) # make facets ( = panels)
  
# the facet wrap takes a 'formula' argument denoted by the tilde sign
# we tell the facet what the group is that should be used for the panels

# lets color by species to look at those clusters

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g, 
                          color = species)) + 
  geom_point(size = 3)+
  facet_wrap( ~ sex)

# let's add some ellipses for the species

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g, 
                          color = species)) + 
  geom_point(size = 3)+
  facet_wrap( ~ sex)+
  stat_ellipse(type = "norm", level = 0.95)

# let's make this pretty!

# outline points, use filled ellipses with transparency

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g, 
                                  fill = species)) + 
  stat_ellipse(geom = "polygon", type = "norm", level = 0.95, alpha = 0.3, color = NA)+
  geom_point(size = 3, shape = 21, color = "black")+
  facet_wrap( ~ sex)+
  NULL
  
# let's get rid of this grey theme etc
# --> ggplot themes

  # themes
  
  # the default theme is really ugly!
  # you can use some preset other themes to modify the plot appearance

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g, 
                          fill = species)) + 
  stat_ellipse(geom = "polygon", type = "norm", level = 0.95, alpha = 0.3, color = NA)+
  geom_point(size = 3, shape = 21, color = "black")+
  facet_wrap( ~ sex)+
  theme_classic()+
  NULL
  
# or

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g, 
                          fill = species)) + 
  stat_ellipse(geom = "polygon", type = "norm", level = 0.95, alpha = 0.3, color = NA)+
  geom_point(size = 3, shape = 21, color = "black")+
  facet_wrap( ~ sex)+
  theme_bw()+
  NULL

# in the theme all arguments take these element options
# this is used to tell the theme that this is a text option
# so element_text, element_line etc
# or element_blank() for removing an element
# the help page for theme will list all the options that can be modified

#### changing text ####

# lets clean up the axis titles etc
# we can further format the x axis labels in the theme options

# changing titles using the labs function

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g, 
                          fill = species)) + 
  stat_ellipse(geom = "polygon", type = "norm", level = 0.95, alpha = 0.3, color = NA)+
  geom_point(size = 3, shape = 21, color = "black")+
  facet_wrap( ~ sex)+
  theme_bw()+
  labs(x = "Flipper length (mm)", 
       y = "Body mass (g)", 
       title = "Figure 1: Penguin size", 
       fill = "Species")+
  NULL

# change text size and move legend

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g, 
                          fill = species)) + 
  stat_ellipse(geom = "polygon", type = "norm", level = 0.95, alpha = 0.3, color = NA)+
  geom_point(size = 3, shape = 21, color = "black")+
  facet_wrap( ~ sex)+
  theme_bw()+
  labs(x = "Flipper length (mm)", 
       y = "Body mass (g)", 
       title = "Figure 1: Penguin size", 
       fill = "Species")+
  theme(axis.title = element_text(size = 14), 
        legend.position = "bottom")+
  NULL

# let's use our own color scheme

install.packages("MetBrewer")
library(MetBrewer)

penguin_color_pal <- met.brewer("Cross", n = 3, type = "Archambault")

ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g, 
                          fill = species)) + 
  stat_ellipse(geom = "polygon", type = "norm", level = 0.95, alpha = 0.3, color = NA)+
  geom_point(size = 3, shape = 21, color = "black")+
  facet_wrap( ~ sex)+
  theme_bw()+
  labs(x = "Flipper length (mm)", 
       y = "Body mass (g)", 
       title = "Figure 1: Penguin size", 
       fill = "Species")+
  theme(axis.title = element_text(size = 14), 
        legend.position = "bottom")+
  scale_fill_manual(values = penguin_color_pal)+
  NULL

#### exporting a plot ####

# you can manually export a plot using the RStudio feature
# but this is annoying if you are re-saving etc

# --> use ggsave function

# you can see that ggsave takes a 'plot' argument
# the default is last_plot(), the plot that is currently open
# but to avoid errors we should write our plot into an object
# and save that

penguin_size_plot <- ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g, 
                                               fill = species)) + 
    stat_ellipse(geom = "polygon", type = "norm", level = 0.95, alpha = 0.3, color = NA)+
    geom_point(size = 3, shape = 21, color = "black")+
    facet_wrap( ~ sex)+
    theme_bw()+
    labs(x = "Flipper length (mm)", 
         y = "Body mass (g)", 
         title = "Figure 1: Penguin size", 
         fill = "Species")+
    theme(axis.title = element_text(size = 14), 
          legend.position = "bottom")+
  scale_fill_manual(values = penguin_color_pal)+
  NULL

ggsave(filename = "analysis/output/penguin_sizes.png", plot = penguin_size_plot, width = 12, 
       height = 10, dpi = 300, units = "cm")

# ggsave will use the file extension to determine the file type
# but you can use the device argument to hard code

# ressources
# https://r-graph-gallery.com/
# colormind.io

#### Challenge - boxplot ####

#Q: make a manual color scheme using hex codes from colormind


ggplot(penguins_narm, aes(x = flipper_length_mm, y = body_mass_g, 
                          fill = species)) + 
  stat_ellipse(geom = "polygon", type = "norm", level = 0.95, alpha = 0.3, color = NA)+
  geom_point(size = 3, shape = 21, color = "black")+
  facet_wrap( ~ sex)+
  theme_bw()+
  labs(x = "Flipper length (mm)", 
       y = "Body mass (g)", 
       title = "Figure 1: Penguin size", 
       fill = "Species")+
  theme(axis.title = element_text(size = 14), 
        legend.position = "bottom")+
  scale_fill_manual(values = c("#2E778F", "#7FC0A6", "#DB3445"))+
  NULL

# we now used an additional mapping option: the fill
# color in boxplots actually controls the line color
# we can use ylab or xlab to seperately set axis titles
# we removed here the x axis labels, as they are the same as the colors
# in the legend


#### optional - packages ####
install.packages("patchwork")
library("patchwork") 
# really simple package for putting multiple plots in one figure

penguin_size_plot/penguin_size_plot # on top of each other

penguin_size_plot + penguin_size_plot # next to each other

install.packages("cowplot")
library("cowplot")

plot_grid(penguin_size_plot, penguin_size_plot, align = "v")


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



