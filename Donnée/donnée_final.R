
#installer le package readxl si nécessaire
install.packages("readxl")

# Obtenir le répertoire de travail actuel
current_directory <- getwd()

# Afficher le répertoire de travail
print(current_directory)
setwd("/Users/justinemanuel/Documents/GitHub/DJDDS-groupe3/Donnée")

      
#Charger les bibliothèques nécessaires
library(readxl)
library(dplyr)

#Charger les fichiers Excel
biomasse_data <- read_excel("BiomasseMoleculaireMicrobienne.xlsx")
terre_data <- read_excel("analyse_de_terre.xlsx")
cleaned_table <- read_excel("DataVdt.xlsx")
parcel_table <- read_excel("TableauxdonnéesParcelle.xlsx")

#Harmoniser les noms des colonnes pour identifier les parcelles
#Dans biomasse_data, la colonne des parcelles est 'code echantillon'
biomasse_data <- biomasse_data %>% rename(Parcelle = 'code echantillon')


#Dans terre_data, la colonne des parcelles est 'Réf échantillon'
terre_data <- terre_data %>% rename(Parcelle = 'Réf échantillon')

cleaned_table <- cleaned_table %>% rename(Parcelle = 'code')

#Maintenant toutes les tables ont une colonne 'Parcelle'

#Fusionner biomasse_data et terre_data sur la colonne 'Parcelle'
merged_data <- merge(biomasse_data, terre_data, by = "Parcelle")

#Ajouter cleaned_table également sur la colonne 'Parcelle'
merged_data <- merge(merged_data, parcel_table, by = "Parcelle")

#Vérifier le résultat
head(merged_data)

write.csv(merged_data, "merged_data.csv", row.names = FALSE)

