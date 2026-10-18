# Function d'affichage dans la console
fun_affichage_pop <- function(pop,n_pop,num_pop,n_gen){
  cat("================ Population ",num_pop,": Génération ",n_gen," ==================\n",sep="")
  
  cat("‖ Il y a ",
      sprintf("%6.2f",pop[1]*100),"% de ",italic("A"),
      " et ",
      sprintf("%6.2f",pop[2]*100),"% de ",italic("a"),
      ".                        ‖\n",sep="")
  
  n_pop_courant <- fun_representation_pop(fun_freq_geno(pop),n_pop)
  
  cat("‖ Soient ",
      red(sprintf("%5.0f",round(n_pop_courant[1])))," rouges, ",
      magenta(sprintf("%5.0f",round(n_pop_courant[2])))," violets et ",
      blue(sprintf("%5.0f",round(n_pop_courant[3])))," bleus.          ‖",
      "\n",
      sep="")
  
  cat("===============================================================\n")
}

# Function qui prend une matrice la transforme en dataframe de colonne A et a et qui
# plot l'Évolution des fréquences alléliques en fonction des générations
affichage1 <- function(df){
  data_evo <- as.data.frame(df)
  # AFFICHAGE GRAPHIQUE
  plot(data_evo$A,
       type = "l",
       col="red",
       ylim =c(0,1),
       main= "Évolution des fréquences alléliques\n en fonction des générations",
       xlab="Générations",
       ylab="Fréquences")
  grid()
  lines(data_evo$a,
        col="blue")
  
  legend("top",
         legend=c("F(A)", "F(a)"),
         col=c("red", "blue"),
         lty=1)
}