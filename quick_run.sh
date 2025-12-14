#!/bin/bash

echo "🚀 Exécution rapide de l'analyse Carrefour..."
echo ""

Rscript Analyse_Carrefour_Complete.R

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Analyse terminée!"
    echo ""
    echo "📊 Graphiques générés:"
    ls -1 *.png 2>/dev/null | while read file; do
        echo "  ✓ $file"
    done
else
    echo "❌ Erreur lors de l'exécution"
    exit 1
fi
