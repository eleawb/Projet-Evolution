#install.packages("crayon")
library(crayon)

source("config.r")
source("fonctions.r")
source("affichages.r")

# Function globale responsable de la simulation
main <- function(nb_gen_sim){
  # On affiche la première pop
  fun_affichage_pop(pop1,n_pop_1,1,1)
  tmp_pop <- pop1
  
  
  # Ici on evite un dataframe et rbind car c lent et on met une matrice qu'on convertira pour graphique
  data_evo <- matrix(
    0,
    nrow = nb_gen_sim + 1,
    ncol = 2,
    dimnames = list(NULL, c("A", "a"))
  )
  data_evo[1,] <- pop1
  for(x in 1:nb_gen_sim){
    old_pop <- tmp_pop
    tmp_pop <- fun_reproduction(old_pop,vect_fitness,n_pop_1)
    
    data_evo[x+1,] <- tmp_pop
    fun_affichage_pop(tmp_pop, n_pop_1, 1,x+1)
    affichage1(data_evo)
  }
}

main(20)




