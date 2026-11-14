# Function d'affichage dans la console
affichage_cons_1 <- function(pop,n_pop,num_pop,n_gen){
  cat(sprintf( "=============== Population %d : Génération %4d ================\n",num_pop,n_gen),sep="")
  
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
affichage_plot_1 <- function(df,nb_pop){
  data_evo <- as.data.frame(df)
  # AFFICHAGE GRAPHIQUE
  plot(data_evo$A,
       type = "l",
       col="red",
       ylim =c(0,1),
       main= paste("Évolution de la fréquences alléliques de A\n en fonction des générations\n pour la population",nb_pop),
       xlab="Générations",
       ylab="Fréquences")
  grid()
  #lines(data_evo$a,col="blue")
  
  legend("top",
         legend=c("F(A)"),#, "F(a)"),
         col=c("red" ,"blue"),
         lty=1)
}


affichage_plot_2 <- function(data_evo_1, data_evo_2,n_final_1, n_final_2) {
  
  # Construction du dataframe
  df <- rbind(
    data.frame(
      Generation = seq_len(nrow(data_evo_1)) - 1,
      Frequence = data_evo_1[, 1],
      Population = "Population 1"
    ),
    data.frame(
      Generation = seq_len(nrow(data_evo_2)) - 1,
      Frequence = data_evo_2[, 1],
      Population = "Population 2"
    )
  )
  parametres <- paste0(
    "PARAMÈTRES DE SIMULATION\n",
    "────────────────────────────────────────────────────\n",
    "Population 1 : N₀ = ", n_pop_1,
    " | Nf = ", n_final_1,
    " | f₀(A) = ", fq_1_A,
    " | Fitness (AA, Aa, aa) = ",
    paste(vect_fitness1, collapse = " / "), "\n",
    
    "Population 2 : N₀ = ", n_pop_2,
    " | Nf = ", n_final_2,
    " | f₀(A) = ", fq_2_A,
    " | Fitness (AA, Aa, aa) = ",
    paste(vect_fitness2, collapse = " / "), "\n",
    
    "────────────────────────────────────────────────────\n",
    "Migration : 1 → 2 = ", prob_migra_1_vers_2,
    " | 2 → 1 = ", prob_migra_2_vers_1, "\n",
    
    "Mutation : A → a = ", prob_muta_A_vers_a,
     " | a → A = ", prob_muta_a_vers_A, "\n"
  )
  # Création du graphique
  p <- ggplot(df, aes(
    x = Generation,
    y = Frequence,
    color = Population
  )) +
    
    geom_line(linewidth = 1) +
    
    scale_color_manual(
      values = c(
        "Population 1" = "#E74C3C",
        "Population 2" = "#3498DB"
      )
    ) +
    
    scale_y_continuous(limits = c(0, 1)) +
    
    labs(
      title = "Évolution de la fréquence allélique de l'alléle A",
      subtitle = "Comparaison des deux populations",
      x = "Générations",
      y = "Fréquence de l'allèle A",
      color = "Population",
      caption = parametres
    ) +
    
    theme_minimal(base_size = 13) +
    
    theme(
      plot.title = element_text(
        face = "bold",
        size = 16,
        hjust = 0.5
      ),
      plot.subtitle = element_text(
        size = 12,
        hjust = 0.5
      ),
      plot.caption = element_text(
        size = 9,
        color = "grey30",
        hjust = 0.5,
        lineheight = 1.5,
        margin = margin(t = 20)
      ),
      
      plot.caption.position = "plot",
      plot.margin = margin(15, 20, 15, 20),
      legend.position = "bottom",
      panel.grid.minor = element_blank()
    )
  
  print(p)
}