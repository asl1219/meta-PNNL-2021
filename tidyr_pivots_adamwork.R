library(tidyr)
library(gapminder)
library(dplyr)

#Life expectancy by country and year

gapminder %>% select(country, year, lifeExp) # good for computation but not for people

#convenient for people
gapminder %>% select(country, year, lifeExp) %>% pivot_wider(names_from = year, values_from = lifeExp) -> wide_table

#other way to flip
gapminder %>% select(country, year, lifeExp) %>% pivot_wider(names_from = country, values_from = lifeExp)

#tidyverse changes missing values to N/A

#opposite operation
wide_table %>% pivot_longer(-country, names_to =  "year")

#same thing
wide_table %>% pivot_longer('1952':'2007', names_to =  "year")

#How to plot all variables at once, one per facet?
# + facet_wrap(-variable)
# But gapminder has each variables in a seperate column. So reshape it
gapminder %>% 
  pivot_longer(lifeExp:gdpPercap, names_to = "variable") %>% ggplot(aes(year,value, group = country, color = continent)) + 
  geom_line() +
  facet_wrap(~variable, scales = "free")
