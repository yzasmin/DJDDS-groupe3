library(readxl)


# Lire la première feuille du fichier Excel
TableauxdonnéesParcelle <- read_excel("TableauxdonnéesParcelle.xlsx")

AnalyseDeTerre <- read_excel("analyse_de_terre.xlsx")

BiomasseMoleculaireMicrobienne <- read_excel("BiomasseMoleculaireMicrobienne.xlsx")

# Si le fichier contient plusieurs feuilles, vous pouvez spécifier la feuille à lire
DataVdt <- read_excel("DataVdt.xlsx", sheet = "DataRetravaille")
 
TableauxdonnéesParcelle
AnalyseDeTerre
BiomasseMoleculaireMicrobienne
DataVdt

AnalyseDeTerre

# Résumé statistique pour chaque colonne
summary(AnalyseDeTerre)

# Boxplots pour visualiser la distribution
library(ggplot2)
ggplot(AnalyseDeTerre, aes(x = '', y = `Argile (déc) (o/oo) g/kg`)) + geom_boxplot() + labs(title="Distribution de l'argile")

# Histogrammes pour visualiser la répartition des variables
ggplot(AnalyseDeTerre, aes(x = `pH eau -`)) + geom_histogram(binwidth = 0.1, fill = "blue", color = "black") + labs(title="Distribution du pH")

# Matrice de corrélation entre les variables pertinentes
correlation_matrix <- cor(AnalyseDeTerre[, c(4:21)], use = "complete.obs")

# Visualiser la matrice de corrélation
library(corrplot)
corrplot(correlation_matrix, method = "circle")

# Charger le package pour l'ACP
library(FactoMineR)

# Réaliser une ACP sur les colonnes numériques
res.pca <- PCA(AnalyseDeTerre[, c(4:21)], scale.unit = TRUE, ncp = 5)

+# Résultats graphiques de l'ACP
plot(res.pca, habillage = 1) # habillage peut être une variable catégorielle pour colorer les points

# Régression linéaire pour prédire le pH en fonction de certaines variables
model <- lm(`pH eau -` ~ `Argile (déc) (o/oo) g/kg` + `Limon Fin (déc) (o/oo) g/kg` + `Sable Fin (déc) (o/oo) g/kg`, data = AnalyseDeTerre)
summary(model)

