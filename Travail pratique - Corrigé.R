#############################################################
#####     I. Chargement et exploration des données      #####
#############################################################

library(tidyverse)
library(questionr)
library(titanic)

data(titanic_train)

d <- titanic_train

# Recodage des variables
d$Pclass <- factor(d$Pclass, levels = c(1, 2, 3),
                   labels = c("Première classe", "Deuxième classe", "Troisième classe"))
d$Survived <- factor(d$Survived, levels = c(0, 1),
                     labels = c("non survécu", "survécu"))
d$Embarked <- factor(d$Embarked, levels = c("C", "Q", "S"),
                     labels = c("Cherbourg", "Queenstown","Southampton"))

# 2. Afficher les 10 premières lignes
head(d, 10)




#############################################################
##################### II. Analyse univariée #################
#############################################################

############### 1. Variables qualitatives ###################

# Effectifs et fréquences de Sex et Pclass
table(d$Sex)
freq(d$Sex)

table(d$Pclass)
freq(d$Pclass)

# Graphique à barres pour Embarked
ggplot(d, aes(Embarked)) +
  geom_bar(fill="red", col="black") +
  labs(title="Répartition des passagers par port d’embarquement",
       x="Port", y="Effectif")

# INTERPRÉTATION : 
# INTERPRÉTATION – Variable Sex :
# Le tableau montre qu’il y a beaucoup plus d’hommes (577) que de femmes (314) à bord.
# Les fréquences indiquent que les hommes représentent environ 65 % des passagers,
# tandis que les femmes représentent seulement 35 %.
# → Le déséquilibre hommes/femmes est important sur le Titanic.

# INTERPRÉTATION – Variable Pclass :
# Les effectifs montrent que la majorité des passagers voyagent en 3e classe (491 personnes, soit 55 %).
# La 1ère classe regroupe 24 % des passagers et la 2e classe environ 21 %.
# → La répartition est très inégale : plus d’un passager sur deux voyage en 3e classe.
# → Cela reflète la composition sociale du Titanic, majoritairement dominée par la 3e classe.




############### 2. Variables quantitatives ###################

### Statistiques descriptives Age et Fare

summary(d$Age)
mean(d$Age, na.rm=TRUE)
sd(d$Age, na.rm=TRUE)

summary(d$Fare)
mean(d$Fare, na.rm=TRUE)
sd(d$Fare, na.rm=TRUE)

### Histogrammes

ggplot(d, aes(Age)) +
  geom_histogram(fill="blue", col="white", bins=20) +
  labs(title="Distribution de l'âge", x="Âge", y="Effectif")

ggplot(d, aes(Fare)) +
  geom_histogram(fill="green", col="white", bins=20) +
  labs(title="Distribution du prix du billet", x="Fare", y="Effectif")

# INTERPRÉTATION :
# INTERPRÉTATION – Variable Age :
# L’histogramme montre que la majorité des passagers ont entre 20 et 40 ans.
# Il y a quelques passagers beaucoup plus âgés (jusqu’à 80 ans),
# mais leur nombre est faible.
# Les statistiques descriptives confirment cette tendance :
# - Moyenne ≈ 29,7 ans
# - Médiane = 28 ans
# Les quartiles montrent également que 50 % des passagers ont entre 20 et 38 ans.
# → Population globalement jeune à bord du Titanic.


# INTERPRÉTATION – Variable Fare :
# La distribution des prix des billets est très asymétrique à droite.
# La grande majorité des passagers ont payé un billet peu cher (moins de 50 unités),
# Les statistiques le confirment :
# - Moyenne ≈ 32,2
# - Médiane ≈ 14,45
# La plupart des passagers se situent dans les classes sociales inférieures,
# où les billets étaient beaucoup moins coûteux.



#############################################################
##################### III. Analyse bivariée #################
#############################################################

#############################################################
### 1. Quantitative vs Quantitative : Age et Fare
#############################################################

### Test de normalité
shapiro.test(d$Age)     # supprimer les NA si nécessaire
shapiro.test(d$Fare)

# Si p < 0.05 → variable non normale

### Test de corrélation
cor.test(d$Age, d$Fare, method="spearman")  # (non-normal)

### Nuage de points
ggplot(d, aes(Age, Fare)) +
  geom_point(size=0.8, col="red") +
  labs(title="Relation entre l'âge et le prix du billet",
       x="Âge", y="Prix du billet")

# INTERPRÉTATION – Corrélation Age ~ Fare (Spearman) :
# Le test de Spearman indique une corrélation positive faible entre l'âge et le prix du billet (rho ≈ 0.135).
# La p-value (< 0.001) montre que cette corrélation est statistiquement significative.
# Toutefois, même si la relation existe, elle reste très faible : 
# → Les passagers plus âgés avaient tendance à payer légèrement plus cher, 
#   mais cette tendance est très limitée et ne permet pas de conclure à une véritable relation forte.




#############################################################
### 2. Qualitative vs Quantitative : Survived vs Age
#############################################################

### Tableau des âges moyens
tapply(d$Age, d$Survived, mean, na.rm=TRUE)

### Test statistique
# Test de normalité
shapiro.test(d$Age)

# Si non normal → wilcox
wilcox.test(Age ~ Survived, data=d)

### Graphique des moyennes
ggplot(d, aes(Survived, Age)) +
  geom_bar(stat="summary", fun="mean",
           fill=c("blue","orange")) +
  labs(title="Âge moyen selon le statut (survie)",
       x="Statut", y="Âge moyen")

# INTERPRÉTATION :
# INTERPRÉTATION – Comparaison de l’âge selon la survie (Test de Wilcoxon) :
# Le test de Wilcoxon compare l'âge des survivants et des non-survivants sans supposer une distribution normale.
# La p-value ≈ 0.16 est largement supérieure à 0.05.
# Conclusion :
# Il n’y a **pas de différence statistiquement significative** entre l’âge moyen (ou médian) des survivants et des non-survivants.
# Autrement dit, l’âge ne semble pas avoir joué un rôle déterminant dans la probabilité de survie,
# même si graphiquement ou intuitivement certaines différences pourraient apparaître.




#############################################################
### 3. Qualitative vs Qualitative : Sex vs Survived
#############################################################

### Tableau de contingence
tab <- table(d$Sex, d$Survived)
tab
prop.table(tab, margin=1)
prop.table(tab, margin=2)

### Test du Chi-2
chisq.test(tab)

### Graphique empilé
ggplot(d, aes(Sex, fill=Survived)) +
  geom_bar() +
  labs(title="Survie selon le sexe",
       x="Sexe", y="Effectif")

# INTERPRÉTATION :
# INTERPRÉTATION – Tableau de contingence Sex × Survived :
# Le tableau brut montre déjà une différence marquée :
# - 233 femmes ont survécu contre seulement 109 hommes.
# - 468 hommes n'ont pas survécu contre seulement 81 femmes.

# Les proportions par ligne (prop.table(..., margin = 1)) indiquent :
# - 74 % des femmes ont survécu.
# - 19 % des hommes ont survécu.
# → La probabilité de survie est donc nettement plus élevée chez les femmes.

# Les proportions par colonne (prop.table(..., margin = 2)) montrent :
# - Parmi l’ensemble des survivants, 68 % sont des femmes.
# - Parmi l’ensemble des non-survivants, 85 % sont des hommes.
# → Ceci confirme que la mortalité est beaucoup plus élevée chez les hommes.

# INTERPRÉTATION – Test du Chi-2 :
# Le test du Chi-2 fournit une statistique X² ≈ 260.7 avec p-value < 2.2e-16.
# La p-value est très largement inférieure à 0.05.
# Conclusion :
# Il existe une relation statistiquement significative entre le sexe et la survie.
# Le sexe a donc un impact important sur les chances de survie :
# les femmes ont survécu beaucoup plus souvent que les hommes.

