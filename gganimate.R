
# Cargar librerías --------------------------------------------------------
library(pacman)
p_load(tidyverse, extrafont, gganimate)


# Requerimientos para {extrafont} -----------------------------------------
loadfonts()

# Instalar estas dependencias
install.packages('gifski')
install.packages('png')


# Importar datos  ---------------------------------------------------------
netflix <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-20/netflix_titles.csv')


# Manipular data y elaborar gráfico animado -------------------------------
a1 <- netflix %>% 
  filter(type == "TV Show") %>% 
  group_by(release_year) %>%
  count() %>% 
  filter(release_year >= 1980) %>% 
  filter(release_year <= 2020) %>% 
  ggplot(aes(x = release_year, y = n)) +
  geom_col() + 
  scale_fill_gradient(low = "#DEDEDE", high = "#e50914") + # color de las barras
  labs(title = "NETFLIX",
       subtitle = "Número de series según año de lanzamiento desde 1980",
       caption = "JorgeHuanca \n @JorgeAHM_98",
       x = "", y = "") +
  theme(axis.text = element_text(colour = "#DEDEDE"), #cambio el
        plot.title = element_text(color = "#e50914",  #texto titulo
                                  size = 50, hjust = .5,
                                  face = "bold", family = "Tw Cen MT"),
        plot.subtitle = element_text(color = "#DEDEDE", #texto subtitulo
                                     hjust = .5, face = "italic"),
        plot.caption = element_text(color = "#DEDEDE", #texto pie
                                    face = "italic"),
        panel.background = element_rect(fill = '#141414'), #fondo
        plot.background = element_rect(fill = "#141414"), #fondo
        panel.border = element_blank(), #panel
        panel.grid.major = element_blank(), #lineas del fondo
        panel.grid.minor = element_blank(),  #lineas del fondo
        legend.position = "none") +  #quito la leyenda
        transition_states(release_year) +
        shadow_mark()

animate(a1, height = 6, width = 8, units = "in", res = 720)


# Exportar animación  -----------------------------------------------------
anim_save("netflix.gif", animation = last_animation())


