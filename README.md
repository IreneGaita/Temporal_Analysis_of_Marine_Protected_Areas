 # Temporal_Analysis_of_Marine_Protected_Areas

## Descrizione del Progetto

Questo progetto si propone di analizzare l'evoluzione delle Aree Marine Protette (MAPs) nei paesi membri dell'OECD dal 2000 al 2022, utilizzando strumenti di statistica ed esplorazione dati implementati in R. L'obiettivo è identificare trend significativi, disuguaglianze regionali e valutare l'efficacia delle politiche di conservazione marina adottate.

## Obiettivi

- Analizzare i trend temporali delle Aree Marine Protette.
- Confrontare l'impegno tra i paesi OECD nella protezione marina.
- Esplorare disparità regionali e identificare pattern geografici rilevanti.
- Valutare l'efficacia delle iniziative di conservazione marina sull'ambiente e sui servizi ecosistemici.

## Dataset

Il dataset utilizzato è stato scaricato dal sito ufficiale dell'OECD e comprende informazioni sulle Aree Marine Protette. Sono state scelte 25 nazioni OECD che nel corso degli anni hanno mostrato cambiamenti o trend di particolare interesse per il periodo 2000-2022. I dati sono stati preprocessati per garantire coerenza e facilità di analisi.

**OECD Dataset Reference**: [Link al Dataset]([https://www.aics.gov.it/oltremare/articoli/pianeta/cop15-cosa-significa-il-global-biodiversity-framework-per-la-cooperazione](https://data-explorer.oecd.org/vis?tm=Sustainable%20ocean%20economy&pg=0&fs[0]=Topic%2C2%7CEnvironment%20and%20climate%20change%23ENV%23%7CBiodiversity%252C%20water%20and%20ecosystems%23ENV_BIO%23%7COcean%23ENV_BIO_OCN%23&fc=Topic&snb=1&vw=ov&df[ds]=dsDisseminateFinalDMZ&df[id]=DSD_SOE%40DF_SOE&df[ag]=OECD.ENV.EPI&df[vs]=1.0&dq=.A....&pd=%2C&to[TIME_PERIOD]=false&ly[cl]=TIME_PERIOD&ly[rw]=COMBINED_MEASURE%2CCOMBINED_UNIT_MEASURE%2CREF_AREA)/)

## Strumenti Utilizzati

- **Linguaggio R**: per la manipolazione dei dati, la creazione di visualizzazioni e l'applicazione di tecniche statistiche.

## Metodologia

### Analisi Temporale:

- Visualizzazione dell'andamento delle MAPs nel tempo per ciascun paese.
- Creazione di serie temporali, diagrammi a barre, rappresentazioni cartografiche, distribuzioni di frequenza.

### Creazione di Boxplot e Diagrammi di Pareto:

- Valutazione delle distribuzioni e identificazione di outlier.

### Analisi Statistica Descrittiva:

- Calcolo di media, mediana, moda, varianza, skewness e curtosi.

### Analisi Cluster:

- Clustering gerarchico e non gerarchico (k-means).
- Visualizzazione dei cluster mediante dendogrammi e screeplot.

### Inferenza Statistica:

- Test del chi-quadrato.
- Analisi di distribuzioni binomiali.

## File del Progetto

- **[Temporal_Analysis_of_Marine_Protected_Areas.pdf](Temporal_Analysis_of_Marine_Protected_Areas.pdf)**: Documentazione completa del progetto, con dettagli sulla metodologia, analisi e risultati.
- **[Temporal_Analysis_of_Marine_Protected_Areas_code.R](Temporal_Analysis_of_Marine_Protected_Areas_code.R)**: Codice R utilizzato per l'analisi e la visualizzazione dei dati.

