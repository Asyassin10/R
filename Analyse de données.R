
#############################################################
##### Installation de package et chargement de données #######
#############################################################

library(tidyverse)
library(questionr)

data(hdv2003)

d <- hdv2003

str(d)
describe(d)

#################################### 
######## Analyse univariée #########
####################################

#----------------------------------
########## Variable quantitative
#----------------------------------

########## Variable quantitative continue


min(d$poids)

max(d$poids)

max(d$poids)-min(d$poids)

mean(d$poids)

median(d$poids)

quantile(d$poids)

quantile(d$poids,probs = 0.3)

summary(d$poids)

mode(d$poids)



sd(d$poids)
mean(d$poids)


Ecart <- abs(d$poids-mean(d$poids))
mean(Ecart)

# Représentation graphique

hist(d$poids)

hist(d$poids, main = "Distribution du poids", 
     xlab = "Classes du poids",
     ylab = "Effectif")

hist(d$poids, main = "Distribution du poids", 
     xlab = "Classes du poids",
     ylab = "Effectif",
     col = "blue")


hist(d$poids, main = "Distribution du poids", 
     xlab = "Classes du poids",
     ylab = "Effectif",
     col = "blue", breaks = 7)


ggplot(d,aes(poids))+
  geom_histogram()

ggplot(d,aes(poids))+
  geom_histogram(fill="red",col="green")

ggplot(d,aes(poids))+
  geom_histogram(fill="red",col="green")+
  labs(title = "Distribution du poids", 
       x = "Classe de poids",
       y = "Effectif")

ggplot(d,aes(poids))+
  geom_histogram(fill="red",col="green",bins = 7)+
  labs(title = "Distribution du poids", 
       x = "Classe de poids",
       y = "Effectif")

##### Variable quantitative discrète


summary(d$freres.soeurs)
mean(d$freres.soeurs, na.rm = TRUE)
sd(d$freres.soeurs)
sum(d$freres.soeurs)

variable1 <- c(10,20,NA)
mean(variable1,na.rm = TRUE)

table(d$freres.soeurs)
table(d$freres.soeurs)/sum(table(d$freres.soeurs))
tab <- table(d$freres.soeurs)
tab

freq(d$freres.soeurs)

# représentation graphique

barplot(table(d$freres.soeurs))

barplot(tab)

barplot(tab, main = "Nombre de frères et de soeurs", 
        xlab = "Nombre", 
        ylab = "Effectif", col = "red")

ggplot(d,aes(freres.soeurs))+
  geom_bar()

ggplot(d,aes(freres.soeurs))+
  geom_bar(fill="red",col="green")+
  labs(title = "Nombre de frères et soeurs",
       x = "Nombre",
       y = "Effectif")


# Variable qualitative

table(d$trav.satisf)

barplot(table(d$trav.satisf), main = "Satisfaction", 
        xlab = "Niveau de satisfaction", 
        ylab = "Effectif", col = "red")

ggplot(d,aes(trav.satisf))+
  geom_bar(fill="red",col="green")+
  labs(title = "Satisfaction",
       x = "Niveau de satisfaction",
       y = "Effectif")


#################################### 
######## Analyse bivariée #########
####################################

### 2 Variables quantitatives

## Tets statistiques
# Test de normalité

shapiro.test(d$age)

shapiro.test(d$poids)

## Si la p-value est inférieure à 0.05 alors la variable ne suit pas une distribution normale

## Test de liaison
# Si les 2 variables suivent une loi normale (test de peason)

cor.test(d$age,d$poids, method = "pearson")
# si la p-value est < 0.05 le test est significatif
# corr =-0.1352257 une relation négative et faible


# Si les 2 variables (ou 1 seule) ne suivent pas une loi normale (test de spearman)

cor.test(d$age,d$poids, method = "spearman")


## Représentations graphiques

plot(d$age,d$poids)

plot(d$age,d$poids)

ggplot(d,aes(age,poids))+
  geom_point(size=0.1,col="red")


ggplot(d,aes(heures.tv,poids))+
  geom_point(size=0.1,col="red")

### 2 variables qualitatives

## test statistique (Test de khi2 "Chi2")

chisq.test(d$sexe,d$cuisine)

### si la p-value est inférieure à 0.05 la relation significative

## Tableaux
tab2 <- table(d$sexe,d$cuisine)

prop.table(tab2)
prop.table(tab2,margin = 1)

prop.table(tab2,margin = 2)

barplot(tab2, col = c("red","green"),legend.text = TRUE)

barplot(tab2, col = c("red","green"),legend.text = TRUE,beside = TRUE)


ggplot(d,aes(sexe,fill = cuisine))+
  geom_bar()

ggplot(d,aes(sexe,fill = cuisine))+
  geom_bar(position = position_dodge())

### Variable qualitative et variable qualitative (2 modalités)


tapply(d$poids,d$sexe,mean,na.rm=TRUE)

## Tests
#Test de normalmité

shapiro.test(d$poids)

## Cas ou la variable quantitative est normale (test de student)

t.test(d$poids~d$sexe)
t.test(d$poids[d$sexe=="Homme"],d$poids[d$sexe=="Femme"])
# si la p-value est inférieure à 0.05 la différence est significative

## Cas ou la variable quantitative n'est pas normale (test de wilcox)

wilcox.test(d$poids~d$sexe)
# si la p-value est inférieure à 0.05 la différence est significative


## Représentation graphique

barplot(tapply(d$poids,d$sexe,mean,na.rm=TRUE),col = c("blue","orange"),
        legend.text = TRUE)

ggplot(d,aes(sexe,poids))+
  geom_bar(stat = "summary",fun ="mean",fill=c("blue","orange"))+
  labs(title = "Poids moyen par sexe",
       x = "Sexe",
       y = "Poids moyen")

#### Analyse multivariée

# Regression linéaire multiple
modele <- lm(data = d, poids ~ sexe + age + nivetud)

summary(modele)
