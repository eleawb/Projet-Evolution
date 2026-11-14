# On nettoie l'enviroment (le global, la console et les graphiques)
rm(list = ls())
cat("\014")
graphics.off()

#install.packages("crayon")
library(crayon)

source("config.r")
source("fonctions.r")
source("affichages.r")

# Function globale responsable de la simulation
main <- function(nb_gen_sim,b_selection,b_migration,b_mutation,b_derive){
  # On affiche les premières générations des pop qui viennet de config.R
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
    
    # Selection naturelle 
    if(b_selection){
      tmp_pop1 <- reproduction(old_pop1,vect_fitness1,n_pop_1)
      tmp_pop2 <- reproduction(old_pop2,vect_fitness2,n_pop_2)
    }else{ # Si cest à false ca fait une reproduction avec 1 de fitness partout
      tmp_pop1 <- reproduction(old_pop1,c(1,1,1),n_pop_1)
      tmp_pop2 <- reproduction(old_pop2,c(1,1,1),n_pop_2)
    }
    

    # Migration
    if (b_migration) {
      res_migr <- migration(tmp_pop1,n_pop_1,tmp_pop2,n_pop_2,prob_migra_1_vers_2,prob_migra_2_vers_1)
      tmp_pop1 <- res_migr$pop1
      tmp_pop2 <- res_migr$pop2
      n_pop_1 <- res_migr$n_pop1
      n_pop_2 <- res_migr$n_pop2
    }
    
    if(b_mutation){
      tmp_pop1 <- mutation(tmp_pop1,n_pop_1)
      tmp_pop2 <- mutation(tmp_pop2,n_pop_2)
    }
    
    if(b_derive){
      tmp_pop1 <- derive(tmp_pop1,n_pop_1)
      tmp_pop2 <- derive(tmp_pop2,n_pop_2)
    }
    #On stock les résultats dans les matrices respectives
    data_evo_1[x+1,] <- tmp_pop1
    data_evo_2[x+1,] <- tmp_pop2
    
    # Et on affiche dans la console
    affichage_cons_1(tmp_pop1, n_pop_1, 1,x+1)
    affichage_cons_1(tmp_pop2, n_pop_2, 2,x+1)
    
  }
  # On affiche les graphiques respectifs
  affichage_plot_1(data_evo_1,1)
  affichage_plot_1(data_evo_2,2)
  
  return(
    list(
      tmp_pop1 = tmp_pop1,
      tmp_pop2 = tmp_pop2,
      n_pop_1 = n_pop_1,
      n_pop_2 = n_pop_2
    )
  )
}
# N_gen selection migration mutation dérive
resultats <-main(200,TRUE,TRUE,TRUE,FALSE)

pop1 <- resultats$tmp_pop1
pop2 <- resultats$tmp_pop2

n_pop_1 <- resultats$n_pop_1
n_pop_2 <- resultats$n_pop_2

