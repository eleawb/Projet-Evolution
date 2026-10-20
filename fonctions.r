library(crayon)


# Function qui prend un vecteur de fréquence des alléles dans une population
# return un vecteur de fréquence génotypique sous panmixie
fun_freq_geno <- function(vect_pop){
  fq_gen <- c(vect_pop[1]**2,2*vect_pop[1]*vect_pop[2],vect_pop[2]**2)
  return (fq_gen)
}



# Function qui prend un vecteur de fréquence génotypique et n la taille de la pop
# return un vecteur du nombre d'individu avec les phénotypes AA Aa aa (aka cb il y a de rouge violet et bleu)
fun_representation_pop <- function(fq_gen,n_pop){
  # int * vect
  n_pop_courant <- n_pop * fq_gen
  return (n_pop_courant)
}

fun_reel_pop <- function(fq_gen,n_pop){
  return(
    rep(
      c("AA","Aa","aa"),
      round(fun_representation_pop(fun_freq_geno(fq_gen),n_pop))
    )
  )
}


# Grande fonction qui permet la création de la génération suivante à partir de vect_pop
# Applique la force de séléction naturelle 
# Return la gén suivante
reproduction <- function(vect_pop,vect_fitness,n_pop) {
  # Fréquence génotypique sous panmixie
  fq_gen <- fun_freq_geno(vect_pop)
  
  n_pop_courant <- fun_representation_pop(fq_gen,n_pop)
  
  # On a deux vect de meme taille aka on peut multiplier
  selection <- n_pop_courant * vect_fitness
  
  # Nouvelle fréq allélique 
  # Ici on recalcule le nb de A et de a qu'on normalise par 2 fois la nouvelle taille de la population
  nv_gen <- c(2*selection[1]+selection[2],2*selection[3]+selection[2]) / (2*sum(selection))
  
  return(nv_gen)
}

# Fonction qui gére la force évolution de la migration
# Prend deux populations en entrée
# return 
migration <-function(pop1,n_pop1,pop2,n_pop2,prob_migra_1_vers_2, prob_migra_2_vers_1){
  
  # On génére un vecteur de type "AA" "AA" .. "Aa".. "aa" qui represente la population
  # et on tire aléatoirement des gens de ce vecteur en fonction de la proba de migration
  
  # MIGRATION POP1 -> POP2
  migrants_from_pop1 <- sample(
    fun_reel_pop( pop1,n_pop1),  
    n_pop1 * prob_migra_1_vers_2) 
  nb_migrants1 <- length(migrants_from_pop1)
  
  # MIGRATION POP2 -> POP1
  migrants_from_pop2 <- sample(
    fun_reel_pop( pop2,n_pop2),  
    n_pop2 * prob_migra_2_vers_1) 
  nb_migrants2 <- length(migrants_from_pop2)
  
  # On compte combien d'allèles on a pris
  ## Pop 1
  nb_A_1 <- 2* sum(migrants_from_pop1 == "AA") + sum(migrants_from_pop1 == "Aa")
  nb_a_1 <- 2* sum(migrants_from_pop1 == "aa") + sum(migrants_from_pop1 == "Aa")
  ## Pop 2
  nb_A_2 <- 2* sum(migrants_from_pop2 == "AA") + sum(migrants_from_pop2 == "Aa")
  nb_a_2 <- 2* sum(migrants_from_pop2 == "aa") + sum(migrants_from_pop2 == "Aa")
  
  # On recalcule la nouvelle taille des pops  
  nb_pop_1_final <- n_pop1 - nb_migrants1 + nb_migrants2
  nb_pop_2_final <- n_pop2 - nb_migrants2 + nb_migrants1
  
  # Pour les retirer de la population qui voit ses migrants partir
  # Donc on reconstruit le vecteur pop1 tmp
  tmp_pop1 <- c(
    (pop1[1]*2*n_pop1 - nb_A_1 + nb_A_2) / (2 * nb_pop_1_final),
    (pop1[2]*2*n_pop1 - nb_a_1 + nb_a_2) / (2 * nb_pop_1_final)
  )
  
  #cat("On tire les génotypes suivants pour ",bold("la pop 1"), ": ",migrants_from_pop1)
  #cat("\nFreq pop1 avant qu'on retire les migrants : ",pop1)
  #cat("\nFreq pop1 après qu'on retire les migrants : ",tmp_pop1)
  
  # Apres il faut les rajouter dans pop2
  #cat("\nFreq pop2 avant qu'on retire les migrants : ",pop2)
  tmp_pop2 <- c(
    (pop2[1]*2*n_pop2 + nb_A_1 - nb_A_2) / (2 * nb_pop_2_final),
    (pop2[2]*2*n_pop2 + nb_a_1 - nb_a_2) / (2 * nb_pop_2_final)
  )
  #cat("\nFreq pop2 après qu'on ajoute les migrants : ",pop2,"\n")
  
  
  # MIGRATION POP2 -> POP1
  
  # On fait un return un peu plus compliqué car on doit recuper plein d'élément
  return(list(
    pop1 = tmp_pop1,
    pop2 = tmp_pop2,
    n_pop1 = nb_pop_1_final,
    n_pop2 = nb_pop_2_final
  ))
}