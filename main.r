#install.packages("crayon")
library(crayon)

source("config.r")
source("fonctions.r")
source("affichages.r")

# Function globale responsable de la simulation
main <- function(nb_gen_sim){
  # On affiche les premières générations des pop
  affichage_cons_1(pop1,n_pop_1,1,1)
  tmp_pop1 <- pop1
  affichage_cons_1(pop2,n_pop_2,2,1)
  tmp_pop2 <- pop2
  
  
  # Ici on evite un dataframe et rbind car c lent et on met une matrice qu'on convertira pour graphique
  # On crée deux matrix pour les deux pop et on remplit la première ligne par nos deux pop
  data_evo_1 <- matrix(
    0,
    nrow = nb_gen_sim + 1,
    ncol = 2,
    dimnames = list(NULL, c("A", "a"))
  )
  data_evo_1[1,] <- pop1
  
  data_evo_2 <- matrix(
    0,
    nrow = nb_gen_sim + 1,
    ncol = 2,
    dimnames = list(NULL, c("A", "a"))
  )
  data_evo_2[1,] <- pop2
  
  for(x in 1:nb_gen_sim){
    # On stock la gen x
    old_pop1 <- tmp_pop1
    old_pop2 <- tmp_pop2
    
    # On genere la x+1
    tmp_pop1 <- fun_reproduction(old_pop1,vect_fitness1,n_pop_1)
    tmp_pop2 <- fun_reproduction(old_pop2,vect_fitness2,n_pop_2)

    # On applique la Migration
    res_migr <- migration(tmp_pop1,n_pop_1,tmp_pop2,n_pop_2,prob_migr)
    #tmp_pop1 <- res_migr[]
    # On stock les résultats dans les matrices respectives
    data_evo_1[x+1,] <- tmp_pop1
    data_evo_2[x+1,] <- tmp_pop2
    
    # Et on affiche dans la console
    affichage_cons_1(tmp_pop1, n_pop_1, 1,x+1)
    affichage_cons_1(tmp_pop2, n_pop_2, 2,x+1)
    cat("\n")
    
  }
  # On affiche les graphiques respectifs
  affichage_plot_1(data_evo_1,1)
  affichage_plot_1(data_evo_2,2)
}

main(1)


