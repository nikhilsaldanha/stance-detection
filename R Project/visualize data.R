data_bodies = read.csv("../data/fnc-1/train_bodies.csv", stringsAsFactors = F)
data_headlineANDstances = read.csv("../data/fnc-1/train_stances.csv", stringsAsFactors = F)

data = merge(data_bodies, data_headlineANDstances, by = "Body.ID")
levels(data$Stance)
nrow(data)
nrow(data_headlineANDstances)
nrow(data_bodies)

# 1 articleBody -> many headlines
# can merge later after extracting features

typeof(data["Body.ID"])
typeof(data["articleBody"])
typeof(data["Headline"])

data[10,]
#=================================================================

## Need this line so qdap will load correctly (with java) when using knitr button. 
dyn.load('/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/jre/lib/server/libjvm.dylib')

library(qdap)
library(dplyr)
library(tm)
library(wordcloud)
library(plotrix)
library(dendextend)
library(ggplot2)
library(ggthemes)
library(RWeka)

#=================================================================
term_count <- freq_terms(data_headlineANDstances$Headline, 20)
plot(term_count)

barplot(table(data_headlineANDstances$Stance))


headlineCOrpus = VCorpus( VectorSource(data$Headline) )
#cleaning: removing stopwords
stopwords("en")
data_headlineANDstances$Headline = removeWords(data_headlineANDstances$Headline, stopwords("en"))
term_count <- freq_terms(data_headlineANDstances$Headline, 20)
plot(term_count)

wordcloud(data_headlineANDstances$Headline, max.words = 100)
