#première pop
n_pop_1 <- 10000

fq_0_A <- 0.7
fq_0_a <- 0.3

fitness_Rouge <- 1
fitness_Violet <- 0.7
fitness_Bleu <- 0.6

prob_pop1_into_pop2 <- 0.1
prob_pop2_into_pop1 <- 0.1 

pop1 <- c(fq_0_A,fq_0_a)
vect_fitness <-c(fitness_Rouge,fitness_Violet,fitness_Bleu)

fun_reproduction <- function(vect_pop,vect_fitness,n_pop) {
  # Fréquence génotypique sous panmixie
  fq_gen <- c(vect_pop[1]**2,2*vect_pop[1]*vect_pop[2],vect_pop[2]**2)
  
  # Cb il y a de rouge, violet, bleu 
  # int * vect
  n_pop_courant <- n_pop * fq_gen
  
  # On a deux vect de meme taille aka on peut multiplier
  selection <- n_pop_courant * vect_fitness
  #print(selection)
  #print(sum(selection))
  
  # Nouvelle fréq allélique 
  # Ici on recalcule le nb de A et de a qu'on normalise par 2 fois la nouvelle taille de la population
  nv_gen <- c(2*selection[1]+selection[2],2*selection[3]+selection[2]) / (2*sum(selection))
  
  print(sum(nv_gen))
  return(nv_gen)
}
pop2 <- fun_reproduction(pop1,vect_fitness,n_pop_1)
print(pop2)

#pop3 <- fun_reproduction(pop2,vect_fitness,n_pop_1)
#print(pop3)

