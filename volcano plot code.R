setwd("C:/Users/{kr.pA}/Downloads")

#all work with test data of first two rows
test = read.csv("methylated data/t1.csv")
test = as.data.frame(test)

for (val in test["ID_REF"])
{
  rownames(test) <- val
}

#this method runs into problems later
test$ID_REF <- NULL

logtest <- test
logtest[, 4:7] <- log(test[4:7], exp(1))


#this is the real stuff with full augmented dataset
dataframe = read.csv("methylated data/values.csv")
typeof(dataframe)
dataframe = as.data.frame(dataframe)

for (val in dataframe["X"])
{
  rownames(dataframe) <- val
}

#dropping extra column
dataframe = dataframe[-c(1)]

logdf <- dataframe
logdf[, 1:94] <- log(dataframe[1:94], exp(1))
#logdf[, 96] <- -log(dataframe[96], 10)

#logdf$gene <- rownames(logdf)
#ggplot(data=logdf, aes(x=t.statistics, y=-log10(p.values), label=gene)) + geom_point() + theme_minimal() + geom_text() + geom_vline(xintercept=c(-75, 75), col="red")

library(EnhancedVolcano)
EnhancedVolcano(logdf, lab = rownames(logdf), legendLabels = c("NS", "t-statistic", "p-value", "p-value and t-statistic"), x='t.statistics', y=('p.values'), xlim = c(-100, 100), xlab = "t-statistics", ylab = "p-values")


#separating into meth and unmethylated data for analysis
even_indexes <- seq(2,94,2)
odd_indexes <- seq(1,94,2)

meth <- logdf[, c(odd_indexes)]
unmeth <- logdf[, c(even_indexes)]
