#install.packages("scatterplot3d", "serialize", "igraph", "grid", "cluster","arulesViz","arules")
library(plyr)
library(knitr)
library(arules)
library(arulesViz)
library(grid)

# Read in csv file and replace all blank space with NA
ChronicDiseaseIndicator = read.csv(file='C:/Users/sonal/Desktop/Applied Data Science/Project/Datasets/mortality/2015_data.csv', header=T)

# Get size of file
expend_11.size = dim(ChronicDiseaseIndicator)

#Extract selected column from the dataset
ChronicDiseaseMortality = ChronicDiseaseIndicator[,c(19,25,26,28)]

# create a new column with the four columns collapsed together
ChronicDiseaseMortality$MergedColumn = apply( ChronicDiseaseMortality[ , c(1,2,3,4) ] , 1 , paste , collapse = "," )

# Write full data file
write.csv(ChronicDiseaseMortality, file = "C:/Users/sonal/Desktop/Applied Data Science/Project/R/DiseaseAssociation.csv",row.names=FALSE, na="")

#Discretize all columns
ChronicDiseaseMortality$manner_of_death <- factor(ChronicDiseaseMortality$manner_of_death)
ChronicDiseaseMortality$X358_cause_recode <- factor(ChronicDiseaseMortality$X358_cause_recode)
ChronicDiseaseMortality$X113_cause_recode <- factor(ChronicDiseaseMortality$X113_cause_recode)
ChronicDiseaseMortality$X39_cause_recode <- factor(ChronicDiseaseMortality$X39_cause_recode)
ChronicDiseaseMortality$MergedColumn <- factor(ChronicDiseaseMortality$MergedColumn)

#Find association rule with default settings
attach(ChronicDiseaseMortality)
rules = apriori(ChronicDiseaseMortality)
inspect(rules)

#Find redundant rule
#subset.matrix <- is.subset(rules, rules)
#subset.matrix[lower.tri(subset.matrix, diag = T)] <- NA
#redundant <- colSums(subset.matrix, na.rm = T) >=1
#which(redundant)

#Remove redundant rules
#rules.pruned <- rules[!redundant]
#inspect(rules.pruned)

plot(rules)
plot(rules, method="graph", control=list(type="items"))
plot(rules, method="paracoord", control=list(reorder=TRUE))
