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
fun_reproduction <- function(vect_pop,vect_fitness,n_pop) {
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
migration <-function(pop1,n_pop1,pop2,n_pop2,prob_migra){
  # On génére un vecteur de type "AA" "AA" .. "Aa".. "aa"
  # et on tire aléatoirement des gens de ce vecteur
  migrants_from_pop1 <- sample(fun_reel_pop( pop1,n_pop1) ,  n_pop1 * prob_migra ) 
  # On compte combien d'allele on a pris 
  nb_A_1 <- 2* sum(migrants_from_pop1 == "AA") + sum(migrants_from_pop1 == "Aa")
  nb_a_1 <- 2* sum(migrants_from_pop1 == "aa") + sum(migrants_from_pop1 == "Aa")
  
  nb_pop_1_restant <- n_pop1 - length(migrants_from_pop1)
  # Pour les retirer de la population qui voit ses migrants partir
  # Donc on reconstruit le vecteur pop1 tmp
  tmp_pop1 <- c(
    (pop1[1] * 2 * n_pop1 - nb_A_1) / (2 * nb_pop_1_restant),
    (pop1[2] * 2 * n_pop1 - nb_a_1) / (2 * nb_pop_1_restant)
  )
  print(migrants_from_pop1)
  print(pop1)
  print(tmp_pop1)
}