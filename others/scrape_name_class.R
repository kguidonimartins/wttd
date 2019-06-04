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
    "pacman"
    )
  )


pacman::p_load_gh(
  "trinker/lexicon",
  "trinker/textclean"
)


############################################################
#                                                          #
#                 código para o módulo 01                  #
#                                                          #
############################################################


url <- "html/Conheça a sua jornada - Welcome to the Django.html"


titulo_aulas <-
  url %>%
  read_html() %>%
  html_nodes("ol") %>%
  html_text() %>%
  str_split("\n\n") %>%
  .[[1]] %>%
  str_replace_all("\n", "")


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
      "M1A", 
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
  str_to_lower() %>%
  str_replace_all(" ", "_") %>%
  str_replace_all(",", "") %>%
  paste0(".md")


if (!file.exists("../modulo_01/m1a01_conheca_a_sua_jornada.md")){
  
  
  for (i in seq_along(completo_aulas_md)) {
    
    
    sink(completo_aulas_md[i])
    cat(paste("#", completo_aulas[i], "-", link_aulas[i]))
    sink()
    
    
  }
  
  
} else {
  
  
  print("esses arquivos já existem")
  
  
}


############################################################
#                                                          #
#                 código para o módulo 02                  #
#                                                          #
############################################################
