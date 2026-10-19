# Fichier qui gére les paramètres de la simulation (permet d'alléger le fichier principal)
#============================================#
#==============POPULATION 1==================#
# effectif pop1
n_pop_1 <- 20

# Fréquences alléliques de la pop1
fq_1_A <- 0.4
fq_1_a <- 0.6
pop1 <- c(fq_1_A,fq_1_a)

# Fitness des couleurs de peau de la pop1
fitness_Rouge1 <- 1
fitness_Violet1 <- 0.999
fitness_Bleu1 <- 1
vect_fitness1 <-c(fitness_Rouge1,fitness_Violet1,fitness_Bleu1)

#============================================#
#==============POPULATION 2==================#
# effectif pop1
n_pop_2 <- 20

# Fréquences alléliques de la pop1
fq_2_A <- 0.2
fq_2_a <- 0.8
pop2 <- c(fq_2_A,fq_2_a)

# Fitness des couleurs de peau de la pop1
fitness_Rouge2 <- 1
fitness_Violet2 <- 1
fitness_Bleu2 <- 1
vect_fitness2 <-c(fitness_Rouge2,fitness_Violet2,fitness_Bleu2)

prob_migr <- 0.25