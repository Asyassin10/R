# 🚀 Guide d'Installation et d'Exécution

## 📋 Table des Matières
1. [Installation Automatique](#installation-automatique)
2. [Installation Manuelle](#installation-manuelle)
3. [Exécution Rapide](#exécution-rapide)
4. [Résolution de Problèmes](#résolution-de-problèmes)

---

## 🎯 Installation Automatique (RECOMMANDÉ)

### Option 1: Script Complet (Installation + Exécution)

Ce script installe tout ce dont vous avez besoin et exécute l'analyse:

```bash
./install_and_run.sh
```

**Ce script va:**
1. ✅ Vérifier si R est installé (sinon l'installer)
2. ✅ Installer les packages R nécessaires (tidyverse, readxl, questionr)
3. ✅ Vérifier que les fichiers de données existent
4. ✅ Exécuter l'analyse complète
5. ✅ Générer tous les graphiques

**Temps d'exécution:** 5-15 minutes (première fois)

---

## ⚡ Exécution Rapide

### Option 2: Si vous avez déjà tout installé

```bash
./quick_run.sh
```

**Ce script va:**
- Exécuter directement l'analyse
- Générer les graphiques
- Afficher les résultats

**Temps d'exécution:** 30 secondes - 2 minutes

---

## 🛠️ Installation Manuelle

### Étape 1: Installer R

#### Sur Linux (Ubuntu/Debian)
```bash
sudo apt-get update
sudo apt-get install -y r-base r-base-dev

# Installer les dépendances système
sudo apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev
```

#### Sur macOS
```bash
# Avec Homebrew
brew install r
```

#### Sur Windows
1. Téléchargez R depuis: https://cran.r-project.org/bin/windows/base/
2. Exécutez l'installateur
3. Suivez les instructions

---

### Étape 2: Installer les Packages R

Ouvrez R et exécutez:

```r
# Installer les packages nécessaires
install.packages("tidyverse")
install.packages("readxl")
install.packages("questionr")
```

Ou utilisez ce script:

```bash
Rscript -e "install.packages(c('tidyverse', 'readxl', 'questionr'), repos='https://cran.rstudio.com/')"
```

---

### Étape 3: Exécuter l'Analyse

```bash
Rscript Analyse_Carrefour_Complete.R
```

---

## 📦 Packages R Requis

| Package | Description | Usage |
|---------|-------------|-------|
| **tidyverse** | Suite de packages pour manipulation de données | Graphiques ggplot2, manipulation dplyr |
| **readxl** | Lecture de fichiers Excel | Import base de données .xlsx |
| **questionr** | Outils statistiques descriptifs | Tables de fréquences, statistiques |

---

## 📊 Résultats Générés

Après l'exécution, vous obtiendrez:

### Graphiques PNG:
- ✅ `graphique_sexe.png` - Distribution par sexe
- ✅ `graphique_statut_client.png` - Répartition clients/non-clients
- ✅ `graphique_age.png` - Distribution par âge
- ✅ `histogramme_satisfaction_globale.png` - Distribution satisfaction
- ✅ `boxplot_satisfaction_globale.png` - Boîte à moustaches satisfaction
- ✅ `histogramme_frequence_visite.png` - Distribution fréquence visites
- ✅ `graphique_sexe_client.png` - Sexe × Statut client
- ✅ `graphique_sexe_client_dodge.png` - Sexe × Statut (côte à côte)
- ✅ `graphique_client_satisfaction.png` - Satisfaction par statut
- ✅ `boxplot_client_satisfaction.png` - Distribution satisfaction/statut
- ✅ `nuage_points_satisfaction_frequence.png` - Corrélation satisfaction/fréquence
- ✅ `graphique_age_sexe.png` - Âge × Sexe

### Statistiques (affichées dans le terminal):
- 📈 Analyses univariées complètes
- 📊 Analyses bivariées avec tests statistiques
- 📝 Interprétations détaillées

---

## 🔧 Résolution de Problèmes

### Problème 1: "R: command not found"

**Solution:**
```bash
# Vérifier si R est installé
which R

# Si non installé, utilisez:
./install_and_run.sh
```

---

### Problème 2: "package 'XXX' is not available"

**Solution:**
```bash
# Réinstaller les packages
Rscript -e "install.packages(c('tidyverse', 'readxl', 'questionr'), repos='https://cran.rstudio.com/', dependencies=TRUE)"
```

---

### Problème 3: "Error in library(XXX) : there is no package called 'XXX'"

**Solution:**
Les packages ne sont pas installés. Exécutez:
```bash
./install_and_run.sh
```

---

### Problème 4: "base de donnees carrefour.xlsx not found"

**Solution:**
Assurez-vous d'être dans le bon répertoire:
```bash
# Vérifier le répertoire
pwd

# Lister les fichiers
ls -la

# Vous devriez voir "base de donnees carrefour.xlsx"
```

---

### Problème 5: Erreur avec les dépendances système (Linux)

**Solution:**
```bash
# Ubuntu/Debian
sudo apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev

# Puis réinstallez les packages R
Rscript -e "install.packages(c('tidyverse', 'readxl', 'questionr'), repos='https://cran.rstudio.com/')"
```

---

### Problème 6: "Permission denied"

**Solution:**
```bash
# Donner les permissions d'exécution
chmod +x install_and_run.sh
chmod +x quick_run.sh

# Puis exécuter
./install_and_run.sh
```

---

## 🎓 Commandes Utiles

### Vérifier la version de R
```bash
R --version
```

### Lister les packages R installés
```bash
Rscript -e "installed.packages()[,c('Package','Version')]"
```

### Vérifier un package spécifique
```bash
Rscript -e "packageVersion('tidyverse')"
```

### Nettoyer les graphiques générés
```bash
rm -f *.png
```

### Relancer uniquement l'analyse
```bash
./quick_run.sh
```

---

## 📝 Structure des Fichiers

```
R/
├── base de donnees carrefour.xlsx    # Base de données
├── Analyse_Carrefour_Complete.R      # Script d'analyse principal
├── install_and_run.sh                # Installation + Exécution
├── quick_run.sh                      # Exécution rapide
├── README.md                         # Documentation projet
├── GUIDE_INSTALLATION.md             # Ce fichier
└── *.png                            # Graphiques générés
```

---

## 🚀 Workflow Recommandé

### Première Utilisation:
```bash
# 1. Installation complète
./install_and_run.sh

# 2. Consulter les résultats
ls *.png
```

### Utilisations Suivantes:
```bash
# Exécution rapide
./quick_run.sh
```

### Modification et Test:
```bash
# 1. Modifier le script R
nano Analyse_Carrefour_Complete.R

# 2. Tester
./quick_run.sh

# 3. Vérifier les graphiques
ls -lh *.png
```

---

## 💡 Conseils

1. **Première fois:** Utilisez `install_and_run.sh` pour tout configurer
2. **Tests rapides:** Utilisez `quick_run.sh` après la première installation
3. **Problèmes:** Consultez la section "Résolution de Problèmes"
4. **Windows:** Utilisez Git Bash ou WSL pour exécuter les scripts shell

---

## 📞 Support

Si vous rencontrez des problèmes:
1. Consultez la section "Résolution de Problèmes" ci-dessus
2. Vérifiez que tous les fichiers sont présents
3. Assurez-vous d'avoir les permissions nécessaires
4. Vérifiez les logs d'erreur affichés

---

## ✅ Checklist Rapide

Avant d'exécuter l'analyse:

- [ ] R est installé
- [ ] Les packages R sont installés (tidyverse, readxl, questionr)
- [ ] Le fichier "base de donnees carrefour.xlsx" existe
- [ ] Le script "Analyse_Carrefour_Complete.R" existe
- [ ] Les scripts shell ont les permissions d'exécution

Si tout est coché ✅, exécutez:
```bash
./quick_run.sh
```

Sinon, exécutez:
```bash
./install_and_run.sh
```

---

**Bonne analyse! 📊🎉**
