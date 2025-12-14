#############################################################
#####     ANALYSE COMPLÈTE - BASE DE DONNÉES CARREFOUR  #####
#####     Analyse Univariée et Bivariée                 #####
#############################################################

# Installation et chargement des packages nécessaires
library(tidyverse)
library(readxl)
library(questionr)

#############################################################
#####     I. CHARGEMENT ET EXPLORATION DES DONNÉES      #####
#############################################################

# Chargement de la base de données Carrefour
carrefour <- read_excel("base de donnees carrefour.xlsx")

# Renommer pour faciliter l'usage
d <- carrefour

# Structure des données
cat("===== STRUCTURE DES DONNÉES =====\n")
str(d)

# Aperçu des premières lignes
cat("\n===== APERÇU DES DONNÉES =====\n")
head(d, 10)

# Résumé statistique
cat("\n===== RÉSUMÉ STATISTIQUE =====\n")
summary(d)

# Afficher les noms de colonnes pour vérification
cat("\n===== NOMS DES COLONNES =====\n")
print(names(d))

# Renommer les colonnes pour faciliter l'analyse
# Utiliser les positions pour éviter les problèmes d'encodage
colnames(d)[2] <- "Client"
colnames(d)[20] <- "Sexe"
colnames(d)[21] <- "Age"
colnames(d)[22] <- "Profession"
colnames(d)[23] <- "Revenu"
colnames(d)[18] <- "Satisfaction.globale"
colnames(d)[11] <- "Frequence.de.visite.du.magasin"

# Convertir la satisfaction globale en variable numérique (OUI=1, NON=0)
d$Satisfaction.globale.num <- ifelse(d$Satisfaction.globale == "OUI", 1, 0)

# Créer une variable numérique pour la fréquence de visite
d$Frequence.visite.num <- case_when(
  d$Frequence.de.visite.du.magasin == "Plus de 5 fois par mois" ~ 6,
  d$Frequence.de.visite.du.magasin == "1 a 5 fois par mois" ~ 3,
  d$Frequence.de.visite.du.magasin == "Moins d'une fois par mois" ~ 0.5,
  TRUE ~ NA_real_
)

#############################################################
#####     II. ANALYSE UNIVARIÉE                          #####
#############################################################

cat("\n\n")
cat("==================================================\n")
cat("     ANALYSE UNIVARIÉE - VARIABLES QUALITATIVES   \n")
cat("==================================================\n\n")

#----------------------------------------------------------
# 1. VARIABLE QUALITATIVE : SEXE
#----------------------------------------------------------

cat("--- 1. ANALYSE DE LA VARIABLE SEXE ---\n\n")

# Tableau des effectifs et fréquences
cat("Effectifs :\n")
print(table(d$Sexe))
cat("\nFréquences :\n")
print(freq(d$Sexe))

# Graphique à barres
ggplot(d, aes(x = Sexe)) +
  geom_bar(fill = c("pink", "lightblue"), col = "black") +
  labs(title = "Répartition des répondants par sexe",
       x = "Sexe",
       y = "Effectif") +
  theme_minimal()

ggsave("graphique_sexe.png", width = 8, height = 6)

cat("\n*** INTERPRÉTATION - SEXE ***\n")
cat("La répartition des répondants montre une distribution entre hommes et femmes.\n")
cat("Cette variable permettra d'analyser si le sexe influence la satisfaction client.\n\n")


#----------------------------------------------------------
# 2. VARIABLE QUALITATIVE : STATUT CLIENT
#----------------------------------------------------------

cat("\n--- 2. ANALYSE DE LA VARIABLE STATUT CLIENT ---\n\n")

# Tableau des effectifs
cat("Effectifs :\n")
print(table(d$Client))
cat("\nFréquences :\n")
print(freq(d$Client))

# Graphique
ggplot(d, aes(x = Client)) +
  geom_bar(fill = "steelblue", col = "black") +
  labs(title = "Répartition selon le statut client",
       x = "Statut (Client Carrefour)",
       y = "Effectif") +
  theme_minimal()

ggsave("graphique_statut_client.png", width = 8, height = 6)

cat("\n*** INTERPRÉTATION - STATUT CLIENT ***\n")
cat("Cette variable indique si les répondants sont déjà clients de Carrefour.\n")
cat("La proportion de clients vs non-clients nous informera sur la représentativité\n")
cat("de l'échantillon et permettra des comparaisons de satisfaction.\n\n")


#----------------------------------------------------------
# 3. VARIABLE QUALITATIVE : TRANCHE D'ÂGE
#----------------------------------------------------------

cat("\n--- 3. ANALYSE DE LA VARIABLE ÂGE ---\n\n")

# Tableau des effectifs
cat("Effectifs :\n")
print(table(d$Age))
cat("\nFréquences :\n")
print(freq(d$Age))

# Graphique
ggplot(d, aes(x = Age)) +
  geom_bar(fill = "coral", col = "black") +
  labs(title = "Répartition des répondants par tranche d'âge",
       x = "Tranche d'âge",
       y = "Effectif") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("graphique_age.png", width = 8, height = 6)

cat("\n*** INTERPRÉTATION - ÂGE ***\n")
cat("La distribution par tranches d'âge permet d'identifier les segments\n")
cat("de clientèle les plus représentés dans l'échantillon.\n")
cat("Cette variable sera cruciale pour analyser si l'âge influence les perceptions\n")
cat("de la marque et la satisfaction.\n\n")


cat("\n\n")
cat("==================================================\n")
cat("   ANALYSE UNIVARIÉE - VARIABLES QUANTITATIVES   \n")
cat("==================================================\n\n")


#----------------------------------------------------------
# 4. VARIABLE QUANTITATIVE : SATISFACTION GLOBALE
#----------------------------------------------------------

cat("\n--- 4. ANALYSE DE LA SATISFACTION GLOBALE ---\n\n")

# Tableau de fréquence de la satisfaction (OUI/NON)
cat("Fréquence de satisfaction :\n")
print(table(d$Satisfaction.globale))
cat("\n")
print(freq(d$Satisfaction.globale))

# Graphique à barres
ggplot(d, aes(x = Satisfaction.globale)) +
  geom_bar(fill = "darkgreen", col = "white") +
  labs(title = "Distribution de la satisfaction globale",
       x = "Satisfait de Carrefour",
       y = "Effectif") +
  theme_minimal()

ggsave("graphique_satisfaction_globale.png", width = 8, height = 6)

cat("\n*** INTERPRÉTATION - SATISFACTION GLOBALE ***\n")
cat("La satisfaction globale indique si les clients sont satisfaits de Carrefour.\n")
cat("La proportion de clients satisfaits (OUI) vs insatisfaits (NON)\n")
cat("est un indicateur clé de la performance de l'enseigne.\n\n")


#----------------------------------------------------------
# 5. VARIABLE QUANTITATIVE : FRÉQUENCE DE VISITE
#----------------------------------------------------------

cat("\n--- 5. ANALYSE DE LA FRÉQUENCE DE VISITE ---\n\n")

# Fréquences par catégorie
cat("Fréquence de visite par catégorie :\n")
print(table(d$Frequence.de.visite.du.magasin))
cat("\n")
print(freq(d$Frequence.de.visite.du.magasin))

# Statistiques descriptives sur la version numérique
cat("\nStatistiques descriptives (version numérique) :\n")
print(summary(d$Frequence.visite.num))
cat("\nMoyenne :", mean(d$Frequence.visite.num, na.rm = TRUE), "visites/mois\n")
cat("Écart-type :", sd(d$Frequence.visite.num, na.rm = TRUE), "\n")

# Graphique à barres
ggplot(d, aes(x = Frequence.de.visite.du.magasin)) +
  geom_bar(fill = "purple", col = "white") +
  labs(title = "Distribution de la fréquence de visite",
       x = "Fréquence de visite",
       y = "Effectif") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("graphique_frequence_visite.png", width = 10, height = 6)

cat("\n*** INTERPRÉTATION - FRÉQUENCE DE VISITE ***\n")
cat("La fréquence de visite mesure la fidélité et l'engagement des clients.\n")
cat("Une fréquence élevée indique une clientèle régulière et fidèle.\n")
cat("Cette variable permettra d'analyser le lien entre fidélité et satisfaction.\n\n")


#############################################################
#####     III. ANALYSE BIVARIÉE                          #####
#############################################################

cat("\n\n")
cat("==================================================\n")
cat("            ANALYSE BIVARIÉE                      \n")
cat("==================================================\n\n")


#----------------------------------------------------------
# ANALYSE 1 : Deux variables QUALITATIVES
# SEXE vs STATUT CLIENT
#----------------------------------------------------------

cat("\n--- ANALYSE 1 : SEXE × STATUT CLIENT ---\n\n")

# Tableau de contingence
tab1 <- table(d$Sexe, d$Client)
cat("Tableau de contingence :\n")
print(tab1)

# Proportions par ligne
cat("\nProportions par ligne (% en fonction du sexe) :\n")
print(prop.table(tab1, margin = 1))

# Proportions par colonne
cat("\nProportions par colonne (% en fonction du statut) :\n")
print(prop.table(tab1, margin = 2))

# Test du Chi-2
cat("\nTest du Chi-2 :\n")
test_chi2_1 <- chisq.test(tab1)
print(test_chi2_1)

# Graphique empilé
ggplot(d, aes(x = Sexe, fill = Client)) +
  geom_bar(position = "fill") +
  labs(title = "Statut client selon le sexe",
       x = "Sexe",
       y = "Proportion",
       fill = "Client Carrefour") +
  theme_minimal()

ggsave("graphique_sexe_client.png", width = 8, height = 6)

# Graphique côte à côte
ggplot(d, aes(x = Sexe, fill = Client)) +
  geom_bar(position = "dodge") +
  labs(title = "Statut client selon le sexe",
       x = "Sexe",
       y = "Effectif",
       fill = "Client Carrefour") +
  theme_minimal()

ggsave("graphique_sexe_client_dodge.png", width = 8, height = 6)

cat("\n*** INTERPRÉTATION - SEXE × STATUT CLIENT ***\n")
if(test_chi2_1$p.value < 0.05) {
  cat("Le test du Chi-2 indique une relation SIGNIFICATIVE (p < 0.05) entre le sexe\n")
  cat("et le statut client. Cela signifie que la proportion de clients Carrefour\n")
  cat("diffère significativement entre hommes et femmes.\n\n")
} else {
  cat("Le test du Chi-2 indique qu'il n'y a PAS de relation significative (p >= 0.05)\n")
  cat("entre le sexe et le statut client. La proportion de clients Carrefour\n")
  cat("est similaire chez les hommes et les femmes.\n\n")
}


#----------------------------------------------------------
# ANALYSE 2 : Variable QUALITATIVE vs Variable QUALITATIVE
# STATUT CLIENT vs SATISFACTION GLOBALE
#----------------------------------------------------------

cat("\n--- ANALYSE 2 : STATUT CLIENT × SATISFACTION GLOBALE ---\n\n")

# Tableau de contingence
tab2 <- table(d$Client, d$Satisfaction.globale)
cat("Tableau de contingence :\n")
print(tab2)

# Proportions par ligne
cat("\nProportions par ligne (% par statut client) :\n")
print(prop.table(tab2, margin = 1))

# Proportions par colonne
cat("\nProportions par colonne (% par satisfaction) :\n")
print(prop.table(tab2, margin = 2))

# Test du Chi-2
cat("\nTest du Chi-2 :\n")
test_chi2_2 <- chisq.test(tab2)
print(test_chi2_2)

# Graphique empilé
ggplot(d, aes(x = Client, fill = Satisfaction.globale)) +
  geom_bar(position = "fill") +
  labs(title = "Satisfaction selon le statut client",
       x = "Statut client",
       y = "Proportion",
       fill = "Satisfait") +
  theme_minimal()

ggsave("graphique_client_satisfaction.png", width = 8, height = 6)

# Graphique côte à côte
ggplot(d, aes(x = Client, fill = Satisfaction.globale)) +
  geom_bar(position = "dodge") +
  labs(title = "Satisfaction selon le statut client",
       x = "Statut client",
       y = "Effectif",
       fill = "Satisfait") +
  theme_minimal()

ggsave("graphique_client_satisfaction_dodge.png", width = 8, height = 6)

cat("\n*** INTERPRÉTATION - STATUT CLIENT × SATISFACTION ***\n")
if(test_chi2_2$p.value < 0.05) {
  cat("Il existe une RELATION SIGNIFICATIVE (p < 0.05)\n")
  cat("entre le statut client et la satisfaction.\n")
  cat("Les clients et non-clients ont des niveaux de satisfaction différents.\n\n")
} else {
  cat("Il n'y a PAS de relation significative (p >= 0.05)\n")
  cat("entre le statut client et la satisfaction.\n")
  cat("Le statut client n'influence pas significativement la satisfaction.\n\n")
}


#----------------------------------------------------------
# ANALYSE 3 : Variable QUALITATIVE vs Variable QUALITATIVE
# SATISFACTION GLOBALE vs FRÉQUENCE DE VISITE
#----------------------------------------------------------

cat("\n--- ANALYSE 3 : SATISFACTION × FRÉQUENCE DE VISITE ---\n\n")

# Tableau de contingence
tab3 <- table(d$Frequence.de.visite.du.magasin, d$Satisfaction.globale)
cat("Tableau de contingence :\n")
print(tab3)

# Proportions par ligne
cat("\nProportions par ligne (% par fréquence) :\n")
print(prop.table(tab3, margin = 1))

# Proportions par colonne
cat("\nProportions par colonne (% par satisfaction) :\n")
print(prop.table(tab3, margin = 2))

# Test du Chi-2
cat("\nTest du Chi-2 :\n")
test_chi2_3 <- chisq.test(tab3)
print(test_chi2_3)

# Graphique empilé
ggplot(d, aes(x = Frequence.de.visite.du.magasin, fill = Satisfaction.globale)) +
  geom_bar(position = "fill") +
  labs(title = "Satisfaction selon la fréquence de visite",
       x = "Fréquence de visite",
       y = "Proportion",
       fill = "Satisfait") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("graphique_frequence_satisfaction.png", width = 10, height = 6)

# Graphique côte à côte
ggplot(d, aes(x = Frequence.de.visite.du.magasin, fill = Satisfaction.globale)) +
  geom_bar(position = "dodge") +
  labs(title = "Satisfaction selon la fréquence de visite",
       x = "Fréquence de visite",
       y = "Effectif",
       fill = "Satisfait") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("graphique_frequence_satisfaction_dodge.png", width = 10, height = 6)

cat("\n*** INTERPRÉTATION - SATISFACTION × FRÉQUENCE ***\n")
if(test_chi2_3$p.value < 0.05) {
  cat("Il existe une RELATION SIGNIFICATIVE (p < 0.05)\n")
  cat("entre la fréquence de visite et la satisfaction.\n")
  cat("Les clients qui visitent plus fréquemment ont des niveaux\n")
  cat("de satisfaction différents de ceux qui visitent moins.\n\n")
} else {
  cat("Il n'y a PAS de relation significative (p >= 0.05) entre\n")
  cat("la fréquence de visite et la satisfaction.\n")
  cat("Ces deux variables sont indépendantes.\n\n")
}


#----------------------------------------------------------
# ANALYSE 4 : SEXE vs ÂGE (Qualitative × Qualitative)
#----------------------------------------------------------

cat("\n--- ANALYSE 4 : SEXE × ÂGE ---\n\n")

# Tableau de contingence
tab4 <- table(d$Sexe, d$Age)
cat("Tableau de contingence :\n")
print(tab4)

# Proportions
cat("\nProportions par ligne (% par sexe) :\n")
print(prop.table(tab4, margin = 1))

# Test du Chi-2
cat("\nTest du Chi-2 :\n")
test_chi2_4 <- chisq.test(tab4)
print(test_chi2_4)

# Graphique
ggplot(d, aes(x = Age, fill = Sexe)) +
  geom_bar(position = "dodge") +
  labs(title = "Répartition par âge et sexe",
       x = "Tranche d'âge",
       y = "Effectif",
       fill = "Sexe") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("graphique_age_sexe.png", width = 10, height = 6)

cat("\n*** INTERPRÉTATION - SEXE × ÂGE ***\n")
if(test_chi2_4$p.value < 0.05) {
  cat("Le test du Chi-2 montre une relation SIGNIFICATIVE (p < 0.05)\n")
  cat("entre le sexe et la tranche d'âge.\n")
  cat("Certaines tranches d'âge sont sur-représentées chez un sexe particulier.\n\n")
} else {
  cat("Il n'y a PAS de relation significative (p >= 0.05) entre le sexe et l'âge.\n")
  cat("La distribution par âge est similaire pour les hommes et les femmes.\n\n")
}


#############################################################
#####     IV. CONCLUSIONS ET RECOMMANDATIONS             #####
#############################################################

cat("\n\n")
cat("==================================================\n")
cat("         CONCLUSIONS DE L'ANALYSE                \n")
cat("==================================================\n\n")

cat("1. ANALYSE UNIVARIÉE :\n")
cat("   - La base de données Carrefour contient des informations riches\n")
cat("     sur les caractéristiques démographiques et comportementales des clients.\n")
cat("   - Les variables de satisfaction permettent d'évaluer la performance\n")
cat("     de l'enseigne sur plusieurs dimensions.\n\n")

cat("2. ANALYSE BIVARIÉE :\n")
cat("   - Les relations entre variables révèlent des insights importants\n")
cat("     pour la stratégie marketing et la gestion de la relation client.\n")
cat("   - L'analyse statistique permet d'identifier les facteurs qui influencent\n")
cat("     significativement la satisfaction et la fidélité.\n\n")

cat("3. RECOMMANDATIONS :\n")
cat("   - Approfondir l'analyse des segments de clientèle les moins satisfaits\n")
cat("   - Étudier les leviers d'amélioration de la satisfaction globale\n")
cat("   - Développer des stratégies ciblées selon les profils démographiques\n\n")

cat("\n*** ANALYSE TERMINÉE AVEC SUCCÈS ***\n")
cat("Tous les graphiques ont été sauvegardés dans le répertoire de travail.\n\n")
