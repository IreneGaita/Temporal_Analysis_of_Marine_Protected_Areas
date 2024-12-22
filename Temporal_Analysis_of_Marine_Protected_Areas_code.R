#Funzione che genera i plot per visualizzare l’andamento dei valori assunti dalle varie nazioni nel corso degli anni.
generaTS<-function(posizione){
  percorso <- sprintf('/Users/irene.gaita/Desktop/Immagini e grafici/Serie Temporali//Serie%s.pdf',posizione)
  pdf(file = percorso)
  rigaAttuale <- as.numeric(sea22[posizione,-1])
  mainString <- sprintf("Serie Temporale %s",y[posizione])
  timeSeries <- ts(rigaAttuale, start = 2000, frequency = 1)
  par(mar=c(5,6,4,1)+.1)
  options(scipen=999)
  plot.ts(timeSeries, main = mainString, ylab = "", xlab= "", type = "o", las = 1, col = "blue", xaxt="n")
  axis(1, at = seq(2000, 2022, by = 1), las = 2)
  mtext("sqkm", side = 2, line = 5)
  dev.off()
}

#Funzione che genera un plot di confronto per visualizzare l'andamneto dei valori dal 2000 al 2022 per Portogallo e Spagna
generaConfrontoTS<-function(posizione1, posizione2) {
  percorso <- sprintf('/Users/irene.gaita/Desktop/Immagini e grafici/ConfrontoSerie/confronto%s-%s.pdf', posizione1, posizione2)
  pdf(file = percorso)
  Portogallo <- as.numeric(sea22[posizione1, -1])
  Svezia <- as.numeric(sea22[posizione2, -1])
  mainString <- sprintf("Confronto tra Portogallo e Svezia")
  timeSeries <- ts(cbind(Portogallo, Svezia), start = 2000, frequency = 1)
  plot(timeSeries, main = mainString, col = "blue", type = "o", xaxt = "n", ylab = "Valore", xlab = "")
  axis(1, at = time(timeSeries), labels = time(timeSeries), las = 2)
  mtext("Anno", side = 1, line = 3)
  print(timeSeries)
  dev.off()
}

#Funzione che genera un barplot per anno per visualizzare il totale delle aree marine protette di ciascuna nazione.
generaBP<-function(anno) {
    percorso <- sprintf('/Users/irene.gaita/Desktop/Immagini e grafici/Barplot/Barplot%s.pdf', anno)
    pdf(file = percorso)
    annoString <- as.character(anno)
    colonna <- sea22[[annoString]]
    mainString <- sprintf("Aree protette del %s", anno)
    par(mar = c(10, 10, 8, 4) + 1)
    options(scipen=999)
    barplot(colonna, main = mainString, las = 2, col = rainbow(25), names.arg = y, ylim = c(0, max(colonna)), xlim = c(0.5, length(x) + 0.5), las = 2)
    abline(h = min(colonna), lty = 2, lwd = 2, col = "red")
    abline(h = max(colonna), lty = 2, lwd = 2, col = "red")
    dev.off()
}

#Funzione che genera le mappe con ggplot2 per gli anni 2000 e 2022.
map<- function(sea22){
  install.packages("ggplot2")
  install.packages("tidyverse")
  library(ggplot2)
  library(tidyverse)
  library(rnaturalearth)
  world <- ne_countries(returnclass = "sf")
  geo_data <- merge(world, sea22, by.x = "name", by.y = "listaNazione")
  mapdata<-map_data("world")
  seamap <- data.frame(sea22)
  colnames(seamap)[colnames(seamap) == "Country"] <- "region"
  mapdata<-left_join(mapdata,seamap,by="region")
  view(mapdata)
  mapdata1 <- mapdata %>% filter(!is.na(`2000`))
  view(mapdata1)
  options(scipen = 999)
  map1 <- ggplot(mapdata, aes(x = long, y = lat, group = group)) +
    geom_polygon(aes(fill = `2000`), color = 'black') +
    scale_fill_gradient(low = 'lightblue', high = 'darkblue')
  map1
  mapdata2 <- mapdata %>% filter(!is.na(`2022`))
  mapdata2
  options(scipen = 999)
  map2 <- ggplot(mapdata, aes(x = long, y = lat, group = group)) +
    geom_polygon(aes(fill = `2022`), color = 'black') +
    scale_fill_gradient(low = 'lightblue', high = 'darkblue')
  map2
}

#Funzione che genera le frequenze assolute per classi di dati
generaFA<-function(anno) {
  annoString <- as.character(anno)
  colonna <- sea22[[annoString]]
  options(scipen = 999)
  tabella_frequenze_assolute <- table(cut(colonna, breaks = c(0, 500, 5000, 50000, 500000,5000000), dig.lab = 7L))
  print(tabella_frequenze_assolute)
}

#Funzione che genera le frequenze relative per classi di dati
generaFR<-function(anno) {
  annoString <- as.character(anno)
  colonna <- sea22[[annoString]]
  options(scipen = 999)
  tabella_frequenze_assolute <- table(cut(colonna, breaks = c(0, 500, 5000, 50000, 500000,5000000), dig.lab = 7L))
  tabella_frequenze_relative <- (tabella_frequenze_assolute / sum(tabella_frequenze_assolute))*100
  print(tabella_frequenze_relative)
}

#Funzione che genera i barplot per le frequenze assolute
generaIFA<-function(anni) {
  for (anno in anni) {
    percorso <- sprintf('/Users/irene.gaita/Desktop/Immagini e grafici/InstogrammiFA/Instogrammi%s.pdf', anno)
    pdf(file = percorso)
    annoString <- as.character(anno)
    colonna <- sea22[[annoString]]
    options(scipen = 999)
    par(mar = c(8, 10, 6, 4) + 0.2)
    tabella_frequenze_assolute <- table(cut(colonna, breaks = c(0, 500, 5000, 50000, 500000, 5000000), dig.lab = 7L))
    labels <- gsub("\\((\\d+),(\\d+)\\]", "\\1-\\2", levels(cut(colonna, breaks = c(0, 500, 5000, 50000, 500000, 5000000), dig.lab = 7L)))
    sfumatura_blu <- colorRampPalette(c("lightblue", "darkblue"))(length(labels))
    barplot(tabella_frequenze_assolute, names.arg = labels, col = sfumatura_blu, main = sprintf("Instogramma frequenze assolute - Anno %s", anno), ylab = "Frequenza",las=2)
    dev.off()
  }
}

#Funzione che genera i grafici a torta per le frequenze relative 
generaPIE<-function(anni) {
  for (anno in anni) {
    percorso <- sprintf('/Users/irene.gaita/Desktop/Immagini e grafici/pie/pie%s.pdf', anno)
    pdf(file = percorso)
    annoString <- as.character(anno)
    colonna <- sea22[[annoString]]
    options(scipen = 999)
    mainString <- sprintf("Frequenza relativa - Anno  %s", anno)
    par(mar = c(8, 5, 6, 6) + 0.2)
    tabella_frequenze_assolute <- table(cut(colonna, breaks = c(0, 500, 5000, 50000, 500000,5000000), dig.lab = 7L))
    if (sum(tabella_frequenze_assolute) > 0) {
      tabella_frequenze_relative <- round((tabella_frequenze_assolute / sum(tabella_frequenze_assolute)) * 100, 1)
      print(tabella_frequenze_relative)
      labels <- gsub("\\((\\d+),(\\d+)\\]", "\\1-\\2", names(tabella_frequenze_relative))
      sfumatura_blu <- colorRampPalette(c("lightblue", "darkblue"))(length(labels))
      pie(tabella_frequenze_relative,  main = mainString,labels = paste(labels, sprintf("(%.1f%%)", tabella_frequenze_relative)), col = sfumatura_blu)
    } else {
      cat(sprintf("Nessun dato disponibile per l'anno %s. Grafico a torta non generato.\n", anno))
    }
    dev.off()
  }
}

#Funzione che genera i boxplot per anno 
generaBoxplot<-function(anno){
  percorso <- sprintf('/Users/irene.gaita/Desktop/Immagini e grafici/Boxplot/Boxplot%s.pdf', anno)
  pdf(file = percorso)
  annoString <- as.character(anno)
  colonna <- sea22[[annoString]]
  mainString = sprintf("BoxPlot anno %s", anno)
  par(mar=c(5,6,4,1)+.1)
  options(scipen = 999)
  scale_values <- seq(0, 3500000, by = 100000)
  boxplot(colonna, main = mainString, xlab = "", col = "lightblue", las = 2, yaxt="n")
  axis(2, at = scale_values, labels = scale_values, las = 2)
  dev.off()
}

#Funzione che genera un Boxplot di confronto tra il 2000 e 2022
generaBoxplotConfronto<-function(anno1, anno2) {
  
  percorso <- sprintf('/Users/irene.gaita/Desktop/Immagini e grafici/ConfrontoBoxplot/ConfrontoBoxplot_%s_%s.pdf', anno1, anno2)
  pdf(file = percorso)
  par(mar = c(8, 5, 6, 4) + 0.2)
  options(scipen = 999)
  boxplot_anno1 <- sea22[[as.character(anno1)]]
  boxplot_anno2 <- sea22[[as.character(anno2)]]
  df_combinato <- data.frame(Anno1 = boxplot_anno1, Anno2 = boxplot_anno2)
  scale_values <- seq(0, 3500000, by = 500000)
  boxplot(df_combinato, col = c("lightblue", "royalblue"),
          main = sprintf("Confronto Boxplot - Anno %s e Anno %s", anno1, anno2),
          outline = TRUE, las = 1, names = c("2000", "2022"))
  axis(2, at = scale_values, labels = scale_values, las = 1)
  box()
  dev.off()
}

#Funzione che genera i diagrammi di pareto per ogni anno 
generaDiagrammaPareto<-function(anni) {
  for (anno in anni) {
    percorso <- sprintf('/Users/irene.gaita/Desktop/Immagini e grafici/DiagrammaPareto/DiagrammaPareto_%s.pdf', anno)
    cat("Percorso del file PDF:", percorso, "\n")
    pdf(file = percorso)
    annoString <- as.character(anno)
    cat("Anno corrente:", annoString, "\n")
    colonna <- sea22[[annoString]]
    cat("Colonna corrente:", colonna, "\n")
    options(scipen = 999)
    tabella_frequenze_assolute <- table(cut(colonna, breaks = c(0, 500, 5000, 50000, 500000,5000000), dig.lab = 7L))
    cat("Tabella frequenze assolute:", tabella_frequenze_assolute, "\n")
    if (sum(tabella_frequenze_assolute) != 0) {
      tabella_frequenze_relative <- (tabella_frequenze_assolute / sum(tabella_frequenze_assolute)) * 100
      cat("Tabella frequenze relative:", tabella_frequenze_relative, "\n")
      indici_ordinati <- order(tabella_frequenze_relative, decreasing = TRUE)
      labels <- names(tabella_frequenze_relative)[indici_ordinati]
      frequenze_ordinate <- tabella_frequenze_relative[indici_ordinati]
      pareto.chart(data = frequenze_ordinate, 
                   main = sprintf("Diagramma di Pareto - Anno %s", anno), 
                   names.arg = labels)
    } else {
      cat("Attenzione: somma delle frequenze assolute zero, impossibile calcolare frequenze relative.\n")
    }
    dev.off()
  }
}

#Funzione che genera la media per anno
generamedia<-function(anni) {
  options(scipen = 999)
  for (anno in anni) {
    annoString <- as.character(anno)
    colonna <- sea22[[annoString]]
    tabella_media <- mean(colonna)
    round(tabella_media,digits=4)
    cat(sprintf("Media per l'anno %s: %f\n", anno, tabella_media))
  }
}

#Funzione che genera la mediana per anno
generamediana<-function(anni) {
  options(scipen = 999)
  for (anno in anni) {
    annoString <- as.character(anno)
    colonna <- sea22[[annoString]]
    tabella_mediana <- median(colonna)
    round(tabella_mediana,digits=4)
    cat(sprintf("Mediana per l'anno %s: %f\n", anno, tabella_mediana))
  }
}

#Funzione che genera i quantili per anno
calcolaQuartili<- function(anni) {
  if (!is.data.frame(sea22)) {
    stop("sea22 non è un dataframe.")
  }
  colonne_anni <- sea22[, as.character(anni), drop = FALSE]
  if (any(!colnames(colonne_anni) %in% as.character(anni))) {
    stop("Almeno una colonna corrispondente agli anni specificati non esiste in sea22.")
  }
  quantili <- lapply(colonne_anni, quantile)
  print(quantili)
  return(quantili)
}

#Funzione che genera la deviazione per anno
generadeviazione<-function(anni) {
  options(scipen = 999)
  for (anno in anni) {
    annoString <- as.character(anno)
    colonna <- sea22[[annoString]]
    deviazione_standard <- sd(colonna)
    round(deviazione_standard,digits=6)
    cat(sprintf("Deviazione standard per l'anno %s: %f\n", anno, deviazione_standard))
  }
}

#Funzione che genera la curtosi per anno
genera_curtosi<-function(anni) {
  options(scipen = 999)
  for (anno in anni) {
    annoString <- as.character(anno)
    colonna <- sea22[[annoString]]
    curtosi_valore <- kurtosis(colonna)
    cat(sprintf("Curtosi per l'anno %s: %f\n", anno, curtosi_valore))
  }
}

#Funzione che genera la skewness per anno
genera_skewness<-function(anni) {
  options(scipen = 999)
  for (anno in anni) {
    annoString <- as.character(anno)
    colonna <- sea22[[annoString]]
    skew <- skewness(colonna)
    cat(sprintf("Skewness per l'anno %s: %f\n", anno, skew))
  }
}

#Funzione che genere Scatterplot con Linea Interpolante per Anno 
visualizza_scatterplot<-function(anni) {
  breaks <- c(0, 500, 5000, 50000, 500000, 5000000)
  for (anno in anni) {
    annoString <- as.character(anno)
    colonna <- sea22[[annoString]]
    p <- ggplot(data = sea22, aes(x = anno, y = colonna)) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
      labs(title = paste("Scatterplot con Linea Interpolante per Anno ", anno),
           x = "Anno",
           y = "Territorio Marino Protetto (sqkm)") +
      theme_minimal()
    for (brk in breaks) {
      p <- p + geom_vline(xintercept = brk, linetype = "dotted", color = "red")
    }
    print(p)
  }
}

#Funzione che genera il coefficiente di correlazione per il 2000 e 2022
coefficientecorrelazione<-function(sea22){
  plot(sea22[["2000"]], sea22[["2022"]], main = "Scatterplot con Linea Interpolante per gli anni 2000 e 2022", xlab = "Territorio marino protetto anno 2000", ylab = "Territorio marino protetto 2022", col = "darkblue")
  abline(lm(sea22[["2022"]] ~ sea22[["2000"]]), col = "blue")
  correlation_coefficient <- cor(sea22[["2000"]], sea22[["2022"]])
  cat("Il coefficiente di correlazione tra gli anni 2000 e 2022 è:", correlation_coefficient, "\n")
}


#Funzione che genera il Dendogramma - metodo gerarchico con 5 cluster
generacentroidi<-function(sea22,listaNazioni){
  dist_matrix <- dist(sea22, method = "canberra", diag = FALSE, upper = FALSE)
  hlc <- hclust(dist_matrix, method = "complete")
  str(hlc)
  plot(
    hlc,
    main = "Dendrogramma clustering",
    xlab = "Metodo gerarchico agglomerativo - legame completo relativo alla distanza di Canberra",
    ylab = "Height",
    labels = listaNazioni,
    hang = -1
  )
  axis(side = 4, at = round(c(0, hlc$height), 2))
  rect.hclust(hlc, k = 5, border = "red")
  clusters <- cutree(hlc, k = 5, h = 5)
  cat("Nazione\tCluster\n")
  for (i in seq_along(listaNazioni)) {
    cat(listaNazioni[i], "\t", clusters[i], "\n")
  }
}

#Funzione che genera i tagli per il dendogramma 
tagliofunc<-function(seabelgio){
taglio <- cutree(tree, k=4, h=NULL)
numTaglio <- table(taglio)
taglioList <- list(taglio)
nb<-nrow(seabelgio)
trH1 <- (numTaglio[[1]]-1) * sum(agvar[1])
trH2 <- (numTaglio[[2]]-1) * sum(agvar[2])
trH3 <- (numTaglio[[3]]-1) * sum(agvar[3])
trH4 <- (numTaglio[[4]]-1) * sum(agvar[4])
sumTrH <- trH1 + trH2 + trH3+trH4
trHI<-(nb-1)*sum(apply(seabelgio[2:23],2,var))
trHI
trB <- trHI - sumTrH
trB
}

#Funzione che genera i centroii con metodo k-means
kmeans<-function(seabelgio){
  km<-kmeans(seabelgio[2:23],centers=4,iter.max = 10,nstart = 1)
  km$totss
  km$withinss
  km$tot.withinss
  km$betweenss
  print(km)
}

#Funzione di distribuzione binomiale
funbinomiale<-function(incrementiaustralia2){
  k <- sum(diff(incrementiaustralia2) > 0)
  k
  n <- length(incrementiaustralia2)
  p <- k / n
  p
  prob_crescita <- dbinom(k, n, p)
  prob_crescita
  plot(k,prob_crescita,
       xlab="x",ylab="P(X= Numero di successi (crescite))",type="h",
       main="n=23,p=0.82")
  library(ggplot2)
  prob_crescita_cumulativa <- pbinom(k, n, p, lower.tail = TRUE)
  prob_crescita_cumulativa
  dati_plot_cdf <- data.frame(x = 0:n, probabilita_crescita_cumulativa = pbinom(0:n, n, p, lower.tail = TRUE))
  plot_cdf <- ggplot(dati_plot_cdf, aes(x, probabilita_crescita_cumulativa)) +
    geom_step(color = "blue") +
    labs(title = " funzione di distribuzione binomiale ",
         x = "Numero di successi (crescite)",
         y = "Probabilità di successo") +
    theme_minimal()
  print(plot_cdf)

  M1 <- sum(0:n * dbinom(0:n, n, p))
  M1
  M2 <- sum((0:n)^2 * dbinom(0:n, n, p))
  M2
  V <- M2 - M1^2
  V
  deviazione_standard <- sqrt(V)
  deviazione_standard
  coefficiente_variazione <- (deviazione_standard / M1) * 100
  coefficiente_variazione
  
  simulazione <- rbinom(1000, n, p)
 
  tabella_normalizzata <- table(simulazione) / length(simulazione)

  barplot(tabella_normalizzata,
          xlab = "Numero di successi (crescite)",
          ylab = "Frequenza relativa",
          xlim = c(0, 23),  # Regola xlim in base ai dati osservati
          main = "Distribuzione Binomiale Simulata - N = 1000",
          col = "skyblue", border = "black",
  )  
  
  media_generata <- mean(simulazione)
  media_generata
  varianza_generata <- var(simulazione)
  varianza_generata
  deviazione_standard_generata <- sd(simulazione)
  deviazione_standard_generata
  coefficiente_variazione_generato <- (deviazione_standard_generata / media_generata) * 100
  coefficiente_variazione_generato
  
  stimap<-mean(sim)/k
  stimap
  
  sim<-rbinom(k, n, p)
  alpha <- 1 - 0.95
  # Calcola il valore critico z
  zalpha <- qnorm(1 - alpha/2, mean = 0, sd = 1)
  n <- length(sim)

  a2 <- k * (n * k + zalpha^2)
  a1 <- -k * (2 * n * mean(sim) + zalpha^2)
  a0 <- n * (mean(sim))^2
  # Calcola le radici del polinomio quadratico/intervallo
  radici <- polyroot(c(a0, a1, a2))
  radici
  
  p0<-0.9
  alpha<-0.05
  qnorm(alpha,mean=0,sd=1)
  
  meancamp<-19/23
  (meancamp-p0)/sqrt(p0*(1-p0)/23)
  
}

