############################################################
#                                                          #
#                       load package                       #
#                                                          #
############################################################


# ipak function: install and load multiple R packages.
# Check to see if packages are installed.
# Install them if they are not, then load them into the R session.
# Forked from: https://gist.github.com/stevenworthington/3178163
ipak <- function(pkg) {
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)){
    install.packages(new.pkg, dependencies = TRUE)
  }
  suppressPackageStartupMessages(
    expr = sapply(
      X = pkg,  
      FUN = require,
      character.only = TRUE
      )
    )
}


ipak(
  c(
    "rvest", 
    "tidyverse", 
    "pacman",
    "fs",
    "here"
    )
  )


pacman::p_load_gh(
  "trinker/lexicon",
  "trinker/textclean"
)


############################################################
#                                                          #
#          create function to scrape and organize          #
#                                                          #
############################################################

scrape_and_organize <- function(html, caminho_modulo, codigo_aulas){
  
  url <- html
  
  fs::dir_create(caminho_modulo)
  
  titulo_aulas <-
    url %>%
    read_html() %>%
    html_nodes("ol") %>%
    html_text() %>% 
    str_replace_all("[:control:]+", "\n") %>% 
    str_split("\n") %>%
    .[[1]] %>%
    .[. != ""]
  
  n_aulas <- length(titulo_aulas)
  
  link_aulas <-
    url %>%
    read_html() %>%
    html_nodes("ol") %>%
    html_nodes("a") %>%
    html_attr("href")
  
  codigo_aulas <- 
    rep(
      paste0(
        codigo_aulas, 
        formatC(
          x = 1:n_aulas, 
          digits = 1, 
          flag = 0, 
          format = "d"
        ),
        ":"
      )
    )
  
  completo_aulas <- paste(codigo_aulas, titulo_aulas)
  
  completo_aulas_md <-
    completo_aulas %>%
    replace_non_ascii() %>%
    str_remove_all(":") %>% 
    str_remove_all("!") %>%
    str_remove_all("\\?") %>%
    str_to_lower() %>%
    str_replace_all(" ", "_") %>%
    str_replace_all(",", "") %>%
    paste0(".md")
  
  
  for (i in seq_along(completo_aulas_md)) {
    
    if (!file.exists(paste0(caminho_modulo, completo_aulas_md[i]))) {
      
      sink(paste0(caminho_modulo, completo_aulas_md[i]))
      cat(paste("#", completo_aulas[i], "-", link_aulas[i]))
      sink()
      
    } else {
      
      message(paste0(caminho_modulo, completo_aulas_md[i]), " já existe")
      
    }
    
  }
  
}


############################################################
#                                                          #
#                        modulo 01                         #
#                                                          #
############################################################


scrape_and_organize(
  html = "html/Conheça a sua jornada - Welcome to the Django.html", 
  caminho_modulo = "../modulo_01/", 
  codigo_aulas = "M1A"
  )


############################################################
#                                                          #
#                        modulo 02                         #
#                                                          #
############################################################


scrape_and_organize(
  html = "html/Como não ficar para trás com seu projeto Django - Welcome to the Django.html", 
  caminho_modulo = "../modulo_02/", 
  codigo_aulas = "M2A"
)



