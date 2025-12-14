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

# Nettoyage des noms de colonnes pour faciliter l'analyse
names(d) <- make.names(names(d))

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

# Statistiques descriptives
cat("Statistiques descriptives :\n")
print(summary(d$Satisfaction.globale))
cat("\nMoyenne :", mean(d$Satisfaction.globale, na.rm = TRUE), "\n")
cat("Écart-type :", sd(d$Satisfaction.globale, na.rm = TRUE), "\n")
cat("Médiane :", median(d$Satisfaction.globale, na.rm = TRUE), "\n")

# Histogramme
ggplot(d, aes(x = Satisfaction.globale)) +
  geom_histogram(fill = "darkgreen", col = "white", bins = 10) +
  labs(title = "Distribution de la satisfaction globale",
       x = "Score de satisfaction",
       y = "Effectif") +
  theme_minimal()

ggsave("histogramme_satisfaction_globale.png", width = 8, height = 6)

# Boîte à moustaches
ggplot(d, aes(y = Satisfaction.globale)) +
  geom_boxplot(fill = "lightgreen", col = "darkgreen") +
  labs(title = "Boîte à moustaches - Satisfaction globale",
       y = "Score de satisfaction") +
  theme_minimal()

ggsave("boxplot_satisfaction_globale.png", width = 6, height = 8)

cat("\n*** INTERPRÉTATION - SATISFACTION GLOBALE ***\n")
cat("La satisfaction globale est une variable quantitative clé pour évaluer\n")
cat("la performance de Carrefour auprès de sa clientèle.\n")
cat("La moyenne et la distribution nous informent sur le niveau général de satisfaction.\n")
cat("Un score élevé indique une bonne perception, un score faible suggère des améliorations nécessaires.\n\n")


#----------------------------------------------------------
# 5. VARIABLE QUANTITATIVE : FRÉQUENCE DE VISITE
#----------------------------------------------------------

cat("\n--- 5. ANALYSE DE LA FRÉQUENCE DE VISITE ---\n\n")

# Statistiques descriptives
cat("Statistiques descriptives :\n")
print(summary(d$Frequence.de.visite.du.magasin))
cat("\nMoyenne :", mean(d$Frequence.de.visite.du.magasin, na.rm = TRUE), "\n")
cat("Écart-type :", sd(d$Frequence.de.visite.du.magasin, na.rm = TRUE), "\n")

# Histogramme
ggplot(d, aes(x = Frequence.de.visite.du.magasin)) +
  geom_histogram(fill = "purple", col = "white", bins = 15) +
  labs(title = "Distribution de la fréquence de visite",
       x = "Nombre de visites",
       y = "Effectif") +
  theme_minimal()

ggsave("histogramme_frequence_visite.png", width = 8, height = 6)

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
# ANALYSE 2 : Variable QUALITATIVE vs Variable QUANTITATIVE
# STATUT CLIENT vs SATISFACTION GLOBALE
#----------------------------------------------------------

cat("\n--- ANALYSE 2 : STATUT CLIENT × SATISFACTION GLOBALE ---\n\n")

# Moyennes par groupe
cat("Satisfaction moyenne par statut client :\n")
moyennes_satisfaction <- tapply(d$Satisfaction.globale, d$Client, mean, na.rm = TRUE)
print(moyennes_satisfaction)

# Test de normalité
cat("\nTest de normalité (Shapiro-Wilk) :\n")
test_normalite_sat <- shapiro.test(d$Satisfaction.globale)
print(test_normalite_sat)

# Test statistique approprié
if(test_normalite_sat$p.value >= 0.05) {
  cat("\nLa variable suit une loi normale → Test de Student\n")
  test_stat_2 <- t.test(Satisfaction.globale ~ Client, data = d)
  print(test_stat_2)
} else {
  cat("\nLa variable ne suit PAS une loi normale → Test de Wilcoxon\n")
  test_stat_2 <- wilcox.test(Satisfaction.globale ~ Client, data = d)
  print(test_stat_2)
}

# Graphique des moyennes
ggplot(d, aes(x = Client, y = Satisfaction.globale)) +
  geom_bar(stat = "summary", fun = "mean",
           fill = c("tomato", "skyblue"), col = "black") +
  labs(title = "Satisfaction moyenne selon le statut client",
       x = "Statut client",
       y = "Satisfaction moyenne") +
  theme_minimal()

ggsave("graphique_client_satisfaction.png", width = 8, height = 6)

# Boîtes à moustaches
ggplot(d, aes(x = Client, y = Satisfaction.globale, fill = Client)) +
  geom_boxplot() +
  labs(title = "Distribution de la satisfaction selon le statut client",
       x = "Statut client",
       y = "Satisfaction globale") +
  theme_minimal() +
  theme(legend.position = "none")

ggsave("boxplot_client_satisfaction.png", width = 8, height = 6)

cat("\n*** INTERPRÉTATION - STATUT CLIENT × SATISFACTION ***\n")
if(test_stat_2$p.value < 0.05) {
  cat("Il existe une DIFFÉRENCE SIGNIFICATIVE (p < 0.05) de satisfaction\n")
  cat("entre les clients et les non-clients de Carrefour.\n")
  if(moyennes_satisfaction[1] > moyennes_satisfaction[2]) {
    cat("Les non-clients ont une satisfaction moyenne plus élevée.\n\n")
  } else {
    cat("Les clients ont une satisfaction moyenne plus élevée.\n\n")
  }
} else {
  cat("Il n'y a PAS de différence significative (p >= 0.05) de satisfaction\n")
  cat("entre les clients et les non-clients de Carrefour.\n")
  cat("Le statut client n'influence pas significativement la satisfaction.\n\n")
}


#----------------------------------------------------------
# ANALYSE 3 : Deux variables QUANTITATIVES
# SATISFACTION GLOBALE vs FRÉQUENCE DE VISITE
#----------------------------------------------------------

cat("\n--- ANALYSE 3 : SATISFACTION × FRÉQUENCE DE VISITE ---\n\n")

# Test de normalité pour les deux variables
cat("Tests de normalité :\n")
test_norm_sat <- shapiro.test(d$Satisfaction.globale)
test_norm_freq <- shapiro.test(d$Frequence.de.visite.du.magasin)
cat("Satisfaction globale :\n")
print(test_norm_sat)
cat("\nFréquence de visite :\n")
print(test_norm_freq)

# Test de corrélation approprié
if(test_norm_sat$p.value >= 0.05 & test_norm_freq$p.value >= 0.05) {
  cat("\nLes deux variables suivent une loi normale → Test de Pearson\n")
  test_corr <- cor.test(d$Satisfaction.globale, d$Frequence.de.visite.du.magasin,
                        method = "pearson")
  print(test_corr)
} else {
  cat("\nAu moins une variable ne suit pas une loi normale → Test de Spearman\n")
  test_corr <- cor.test(d$Satisfaction.globale, d$Frequence.de.visite.du.magasin,
                        method = "spearman")
  print(test_corr)
}

# Nuage de points
ggplot(d, aes(x = Frequence.de.visite.du.magasin, y = Satisfaction.globale)) +
  geom_point(col = "darkblue", size = 2, alpha = 0.6) +
  geom_smooth(method = "lm", col = "red", se = TRUE) +
  labs(title = "Relation entre satisfaction et fréquence de visite",
       x = "Fréquence de visite (nombre)",
       y = "Satisfaction globale") +
  theme_minimal()

ggsave("nuage_points_satisfaction_frequence.png", width = 8, height = 6)

cat("\n*** INTERPRÉTATION - SATISFACTION × FRÉQUENCE ***\n")
if(test_corr$p.value < 0.05) {
  cat("Il existe une CORRÉLATION SIGNIFICATIVE (p < 0.05) entre la satisfaction\n")
  cat("et la fréquence de visite.\n")
  cat("Coefficient de corrélation :", round(test_corr$estimate, 3), "\n")

  if(test_corr$estimate > 0.5) {
    cat("→ Corrélation POSITIVE et FORTE : plus les clients sont satisfaits,\n")
    cat("  plus ils visitent fréquemment le magasin.\n\n")
  } else if(test_corr$estimate > 0.3) {
    cat("→ Corrélation POSITIVE et MODÉRÉE : une satisfaction plus élevée\n")
    cat("  est associée à une fréquence de visite légèrement plus importante.\n\n")
  } else if(test_corr$estimate > 0) {
    cat("→ Corrélation POSITIVE et FAIBLE : il existe un lien positif mais limité\n")
    cat("  entre satisfaction et fréquence de visite.\n\n")
  } else if(test_corr$estimate < -0.3) {
    cat("→ Corrélation NÉGATIVE : plus les clients sont satisfaits,\n")
    cat("  moins ils visitent le magasin (résultat contre-intuitif à investiguer).\n\n")
  } else {
    cat("→ Corrélation NÉGATIVE et FAIBLE.\n\n")
  }
} else {
  cat("Il n'y a PAS de corrélation significative (p >= 0.05) entre\n")
  cat("la satisfaction et la fréquence de visite.\n")
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
