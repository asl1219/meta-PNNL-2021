library(dplyr)
libarry(tidyr)
library(ggplot2)
library(gapminder)


gapminder

gapminder %>% print
gapminder %>% head
gapminder %>%(n = 20)
gapminder %>%
  print %>%
  summary #what is non-piped equivalent?
summary(print(gapminder))

gapminder %>% filter(year == 1977) %>% ggplot(aes(gdpPercap, lifeExp, size = pop, color = continent)) + geom_point() + scale_x_log10()

select(gapminder, pop, year)
gapminder %>% select(pop, year)
gapminder %>% select(-lifeExp, -gdpPercap)
gapminder %>% select(-1)

gapminder %>% filter(country == "Egypt") %>% select(-continent, -country) -> Egypt
Egypt

library(tidyr)

Egypt %>% gather(variable, value, lifeExp, pop, gdpPercap)

Egypt %>% gather(variable, value, -year) %>% ggplot(aes(year, value)) + geom_line() + facet_wrap(~variable, scales = "free")

Egypt %>% gather(variable, value, lifeExp)

Egypt %>% gather(variable, value, -lifeExp)

Egypt %>% gather(variable, value, -year) %>% spread(year, value)

gapminder %>% unite(coco, country, continent)
gapminder %>% unite(coco, country, continent) %>% separate(coco, into = c("country", "continent"), sep = "_", extra = "merge")
gapminder %>% mutate(logpop = log(pop))
gapminder %>% rename(population = pop)

#summarizing data

gapminder %>% group_by(country)

gapminder %>% group_by(country) %>% summarise(max(pop))

gapminder %>% group_by(country) %>% summarise(maxpop = max(pop))

gapminder %>% select(-continent, -year) %>% group_by(country) %>% summarise_all(max)
                     
gapminder %>% select(country, pop) %>% group_by(country) %>% summarise_all(max)

gapminder %>% select(-year) %>% group_by(country) %>% summarise_if(is.numeric(, funsmin, max, mean)) %>% gather(variable, value, -country) %>%
                                                                     seperate(variable, into = c("variable", "stat")) %>% spread(stat, value)

#babynames
library(babynames)
babynames

babynames %>% group_by(year, sex) %>% summarise(prop = max(prop), name = name[which.max(prop)])

babynames %>% group_by(year) %>% summarize(sum(n))

#my version
babynames %>% group_by(year) %>% filter(name == "Adam") %>% summarize(num = sum(n)) %>% ggplot(aes(year, num)) + geom_line() + guides()

babynames %>% filter(name == "Adam") %>% qplot(year, n, color = sex, data = .)

babynames %>% group_by(year, sex) %>% mutate(rank = row_number(desc(n))) %>% filter(name == "Benjamin") %>% filter(name == "Benjamin") %>% qplot(year, rank, color = sex, data = .)

#tree_diameter_data %>% gather(date, diameter, -treatment) >%> arrange(date) %>% group_by(tree_id) %>% mutat(growth = diameter - firt(diameter)) %>% group_by(treatment, species) %>%
#can't follow slides downward