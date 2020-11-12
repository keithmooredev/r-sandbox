# Procedure to generate a linear model for each level of a factor
# and extract the p-values from each model into a dataframe.

# Uncomment to install tidymodels, if necessary.
#install.packages("tidymodels")

library(broom)

setwd('~/Projects/r-sandbox')

mydata <- read.csv('sample.csv')

pop_list <- levels(mydata$pop)

pvals=list()

for(i in pop_list) {
  model <- lm(tb~ts, data = subset(mydata, pop==i))
  tidymodel <- tidy(model)
  pvals <- c(pvals, tidymodel[[2,5]])
}

df <- data.frame(pop_list, I(pvals))
colnames(df) = c('pop', 'p-value')
head(df)
