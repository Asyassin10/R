library(readxl)

# Charger le fichier
d <- read_excel("base de donnees carrefour.xlsx")

# Afficher tous les noms de colonnes
cat("=== NOMS DES COLONNES ===\n")
for (i in 1:length(names(d))) {
  cat(i, ": ", names(d)[i], "\n", sep="")
}
