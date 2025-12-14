#!/bin/bash

echo "============================================"
echo "  Installation et Exécution de l'Analyse  "
echo "============================================"
echo ""

# Couleurs pour l'affichage
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Vérifier si R est installé
echo -e "${BLUE}[1/4] Vérification de l'installation de R...${NC}"
if ! command -v R &> /dev/null
then
    echo -e "${RED}R n'est pas installé. Installation en cours...${NC}"

    # Détection du système d'exploitation
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        sudo apt-get update
        sudo apt-get install -y r-base r-base-dev

        # Dépendances pour les packages R
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

    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if ! command -v brew &> /dev/null
        then
            echo "Homebrew n'est pas installé. Installation de Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install r

    else
        echo -e "${RED}Système d'exploitation non supporté automatiquement.${NC}"
        echo "Veuillez installer R manuellement depuis: https://cran.r-project.org/"
        exit 1
    fi

    echo -e "${GREEN}✓ R installé avec succès!${NC}"
else
    echo -e "${GREEN}✓ R est déjà installé!${NC}"
    R --version | head -n 1
fi

echo ""
echo -e "${BLUE}[2/4] Installation des packages R nécessaires...${NC}"

# Créer un script R pour installer les packages
cat > /tmp/install_packages.R << 'RSCRIPT'
# Fonction pour installer un package s'il n'est pas déjà installé
install_if_missing <- function(package) {
  if (!require(package, character.only = TRUE, quietly = TRUE)) {
    cat(paste("Installation de", package, "...\n"))
    install.packages(package, repos = "https://cran.rstudio.com/", dependencies = TRUE, quiet = FALSE)
    cat(paste("✓", package, "installé!\n"))
  } else {
    cat(paste("✓", package, "déjà installé!\n"))
  }
}

# Liste des packages nécessaires
packages <- c("tidyverse", "readxl", "questionr")

cat("\n=== Installation des packages R ===\n\n")

# Installer chaque package
for (pkg in packages) {
  install_if_missing(pkg)
}

cat("\n=== Tous les packages sont installés! ===\n")
RSCRIPT

# Exécuter le script d'installation des packages
Rscript /tmp/install_packages.R

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Tous les packages R sont installés!${NC}"
else
    echo -e "${RED}✗ Erreur lors de l'installation des packages R${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}[3/4] Vérification des fichiers nécessaires...${NC}"

# Vérifier que le fichier Excel existe
if [ -f "base de donnees carrefour.xlsx" ]; then
    echo -e "${GREEN}✓ Base de données Carrefour trouvée!${NC}"
else
    echo -e "${RED}✗ Fichier 'base de donnees carrefour.xlsx' non trouvé!${NC}"
    echo "Assurez-vous que le fichier est dans le répertoire courant."
    exit 1
fi

# Vérifier que le script d'analyse existe
if [ -f "Analyse_Carrefour_Complete.R" ]; then
    echo -e "${GREEN}✓ Script d'analyse trouvé!${NC}"
else
    echo -e "${RED}✗ Fichier 'Analyse_Carrefour_Complete.R' non trouvé!${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}[4/4] Exécution de l'analyse...${NC}"
echo "================================================"
echo ""

# Exécuter le script d'analyse
Rscript Analyse_Carrefour_Complete.R

if [ $? -eq 0 ]; then
    echo ""
    echo "================================================"
    echo -e "${GREEN}✓✓✓ ANALYSE TERMINÉE AVEC SUCCÈS! ✓✓✓${NC}"
    echo "================================================"
    echo ""
    echo "📊 Résultats générés:"
    echo "  - Graphiques PNG dans le répertoire courant"
    echo "  - Statistiques affichées ci-dessus"
    echo ""
    echo "📁 Fichiers graphiques créés:"
    ls -lh *.png 2>/dev/null | awk '{print "  - " $9 " (" $5 ")"}'
    echo ""
else
    echo -e "${RED}✗ Erreur lors de l'exécution de l'analyse${NC}"
    exit 1
fi

echo "============================================"
echo "  Pour relancer l'analyse, exécutez:      "
echo "  ./install_and_run.sh                    "
echo "============================================"
