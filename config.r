# Fichier qui gére les paramètres de la simulation (permet d'alléger le fichier principal)

# effectif pop1
n_pop_1 <- 10000

# Fréquences alléliques de la pop1
fq_1_A <- 0.1
fq_1_a <- 0.9
pop1 <- c(fq_1_A,fq_1_a)

# Fitness des couleurs de peau
fitness_Rouge <- 1
fitness_Violet <- 0.9
fitness_Bleu <- 0.84
vect_fitness <-c(fitness_Rouge,fitness_Violet,fitness_Bleu)

prob_pop1_into_pop2 <- 0.1
prob_pop2_into_pop1 <- 0.1 