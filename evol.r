#install.packages("crayon")
library(crayon)

# effectif pop1
n_pop_1 <- 10000

# Fréquences alléliques de la pop1
fq_1_A <- 0.5
fq_1_a <- 0.5
pop1 <- c(fq_1_A,fq_1_a)

# Fitness des couleurs de peau
fitness_Rouge <- 1
fitness_Violet <- 0.7
fitness_Bleu <- 0.6
vect_fitness <-c(fitness_Rouge,fitness_Violet,fitness_Bleu)

prob_pop1_into_pop2 <- 0.1
prob_pop2_into_pop1 <- 0.1 

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


fun_affichage_pop <- function(pop,n_pop,num_pop,n_gen){
  cat("================ Population ",num_pop,": Génération ",n_gen," ==================\n",sep="")
  
  cat("‖ Il y a ",
      sprintf("%6.2f",pop[1]*100),"% de ",italic("A"),
      " et ",
      sprintf("%6.2f",pop[2]*100),"% de ",italic("a"),
      ".                        ‖\n",sep="")
  
  n_pop_courant <- fun_representation_pop(fun_freq_geno(pop),n_pop)
  
  cat("‖ Soit ",
      red(sprintf("%5.0f",round(n_pop_courant[1])))," rouges, ",
      magenta(sprintf("%5.0f",round(n_pop_courant[2])))," violets et ",
      blue(sprintf("%5.0f",round(n_pop_courant[3])))," bleus.            ‖",
      "\n",
      sep="")
  
  cat("===============================================================\n")
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
  
  print(sum(nv_gen))
  return(nv_gen)
}

fun_affichage_pop(pop1,n_pop_1,1,1)
tmp_pop <- pop1

for(x in 1:10){
  old_pop <- tmp_pop
  tmp_pop <- fun_reproduction(old_pop,vect_fitness,n_pop_1)
  
  fun_affichage_pop(tmp_pop, n_pop_1, 1,x+1)
}


