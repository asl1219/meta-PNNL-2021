
library(tidyr)
library(gapminder)
library(dplyr)

# Let's say we want a nice table of life expectancy by country and year
gapminder %>%
  select(country, year, lifeExp)  # this is good for computation but not for people

# This is convenient for people:
gapminder %>%
  select(country, year, lifeExp) %>%
  pivot_wider(names_from = year, values_from = lifeExp) ->
  wide_table

# We could also flip this:
gapminder %>%
  select(country, year, lifeExp) %>%
  pivot_wider(names_from = country, values_from = lifeExp)

# We also can do the opposite operation, wide to long:
wide_table %>%
  pivot_longer(-country, names_to = "year")
# Equivalent:
wide_table %>%
  pivot_longer(`1952`:`2007`, names_to = "year")

# I would like to plot all the variables at once, one in each facet (panel)
# + facet_wrap(~variable)
# But gapminder has each variable in a separate column. So, reshape it
library(ggplot2)
gapminder %>%
  pivot_longer(lifeExp:gdpPercap, names_to = "variable") %>%
  ggplot(aes(year, value, group = country, color = continent)) +
  geom_line() +
  facet_wrap(~variable, scales = "free")

# The styler package is neat and will auto-reformat code following a style guide

# Have we visited places?
visits <- structure(list(continent = c("Asia", "Europe", "Africa", "Americas",
                                       "Oceania"),
                         Ben_visited = c(TRUE, TRUE, TRUE, TRUE, FALSE),
                         Natanel_visited = c(FALSE, TRUE, FALSE, TRUE, FALSE),
                         Adam_visited = c(TRUE, FALSE, FALSE, TRUE, FALSE)),
                    class = "data.frame", row.names = c(NA, -5L))

gapminder %>% left_join(visits, by = "continent")

gapminder %>%
  left_join(visits, by = "continent") %>%
  ggplot(aes(year, lifeExp, color = Adam_visited, group = country)) + geom_line()

# If the join column names differ, need to be explicit
visits %>% rename(landmass = continent) -> visits1
gapminder %>% left_join(visits1, by = c("continent" = "landmass"))

# Kind of slick and can save you work: anti_join()
visits %>% filter(continent != "Europe") -> visits_no_europe
gapminder %>% anti_join(visits_no_europe)

# If I wanted to know what rows DON'T have a match, two ways:
# 1. use anti_join as above
# 2. use left_join and filter (two steps, not as elegant, but works)
gapminder %>% left_join(visits_no_europe) %>% filter(is.na(Ben_visited))
