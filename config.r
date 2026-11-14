# Fichier qui gére les paramètres de la simulation (permet d'alléger le fichier principal)

prob_migra_1_vers_2 <- 0.035
prob_migra_2_vers_1 <- 0.05

prob_muta_A_vers_a <- 0.004
prob_muta_a_vers_A <- 0.005
#============================================#
#==============POPULATION 1==================#
# effectif pop1
n_pop_1 <- 1000

# Fréquences alléliques de la pop1
fq_1_A <- 0.5
fq_1_a <- 0.5
pop1 <- c(fq_1_A,fq_1_a)

# Fitness des couleurs de peau de la pop1
fitness_Rouge1 <- 0.6
fitness_Violet1 <- 0.7
fitness_Bleu1 <- 0.6
vect_fitness1 <-c(fitness_Rouge1,fitness_Violet1,fitness_Bleu1)

#============================================#
#==============POPULATION 2==================#
# effectif pop1
n_pop_2 <- 1005

# Fréquences alléliques de la pop1
fq_2_A <- 0.4
fq_2_a <- 0.6
pop2 <- c(fq_2_A,fq_2_a)

# Fitness des couleurs de peau de la pop1
fitness_Rouge2 <- 0.5
fitness_Violet2 <- 0.9
fitness_Bleu2 <- 0.9
vect_fitness2 <-c(fitness_Rouge2,fitness_Violet2,fitness_Bleu2)

