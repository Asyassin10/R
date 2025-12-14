




######## Création d'objets ########
###################################

# Scalaire

x = 10
x

x <- 15

prenom <- "Hicham"

# Vecteur 

vect1 <- c(10,20,30)
vect1

prenoms <- c("Hicham", "Rachid", "Ahmed")

vect2 <- 1:4
vect3 <- seq(1,5,0.5)
vect3 <- seq(from =1, by=0.6,, to=4)
?seq
rep(1,10)
rep(vect2,2)
rep(c(1,2),3)

taille : 1.55 1.67 1.52

taille <- c(1.55,1.67,1.52)

satisfaction <- c(FALSE,TRUE,FALSE)

taille

taille[1]
taille[c(1,3)]

taille[c(TRUE,FALSE,TRUE)]


taille>1.6
taille<1.6
taille==1.55

prenoms[taille==1.55]


# Facteur

?factor
genre <- factor(c(0,1,1,0),levels = c(0,1),labels = c("Homme","Femme"))
genre

vect0 <- c(1,2,3)

facteur <- as.factor(vect0)
facteur <- as.factor(vect0, levels = c(1,2,3),labels = c("BIen","AB", "TB"))
?as.factor
# Matrice

matrice1 <- matrix(1:16,4,4)
matrice1
matrice2 <- matrix(1:16,4,4,byrow = TRUE)
matrice2
matrice1[1,]
matrice1[,2]
matrice1[2,3]
matrice1[c(1,2),3]

vect4 <- 1:100

# liste

scalaire <- 45

liste1 <- list(x = 14, y=c(4,3,2,1), z = matrix(c(11,12,13,14),2,2))

liste1 <- list(x = 14,
               y=c(4,3,2,1),
               z = matrix(c(11,12,13,14),2,2))
liste1
liste1$x
liste1$y
liste1$z
liste1$z[2,2]

liste1 <- list(14,
               c(4,3,2,1),
               matrix(c(11,12,13,14),2,2))

liste1[3][1,2]
liste1[[3]][1,2]

liste2 <- list(x=scalaire,y=vect4,z=matrice2)
liste2$y


# Dataframe

database <- data.frame(nom = c("nom1","nom2","nom3"),
                       age = c(24,23,45),
                       salaire = c(4000,4500,NA))
database$nom
View(matrice1)
View(database)
rm(liste1)
rm(ls())
rm(list = ls())


