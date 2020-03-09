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

data_uncleaned = read.csv("../data/emergent/url-versions-2015-06-14.csv", stringsAsFactors = F)
data_cleaned = read.csv("../data/emergent/url-versions-2015-06-14-clean.csv", stringsAsFactors = F)

data_uncleaned = data_uncleaned[ , c("claimHeadline", "articleHeadline", "articleHeadlineStance")]
data_cleaned = data_cleaned[ , c("claimHeadline", "articleHeadline", "articleHeadlineStance")]

data_cleaned$articleHeadlineStance = as.factor(data_cleaned$articleHeadlineStance)
data_uncleaned$articleHeadlineStance = as.factor(data_uncleaned$articleHeadlineStance)

data_uncleaned = subset(data_uncleaned, articleHeadlineStance %in%  c("for", "against", "observing"))
data_uncleaned = data_uncleaned[(!is.na(data_uncleaned$articleHeadline) | data_uncleaned$articleHeadline==""), ]

data_uncleaned[22,  ]

#=================================================================
summary(data_uncleaned)
summary(data_cleaned)

nrow(data_uncleaned)
nrow(data_cleaned)

# 1 claim -> many Headlines

#=================================================================

data = data_cleaned
colnames(data) = c("claim", "headline", "stance")
summary(data)

term_count <- freq_terms(data$headline, 30)
plot(term_count, main = "Headline word frequency")

term_count <- freq_terms(data$claim, 30)
plot(term_count, main = "Claim word frequency")

barplot(table(data$stance))

wordcloud(data$headline, max.words = 100, random.order = F)
wordcloud(data$claim, max.words = 100, random.order = F)

#==================================================================
data = data_cleaned
stopwords("en")
length(stopwords("en"))
neg_stops = c("isn't", "aren't","wasn't","weren't","hasn't","haven't","hadn't",
              "doesn't","don't","didn't","won't","wouldn't","shan't","shouldn't",
              "can't","cannot","couldn't","mustn't","no","nor","not")
sup_neg_stops = c("against", "should", "could", "for")

stops = setdiff(stopwords("en"), neg_stops)
stops = setdiff(stops, sup_neg_stops)
stops
length(stops)

data_wo_stops = data[, c("articleHeadline", "articleId")]
data_wo_non_neg_stops = data[, c("articleHeadline", "articleId")]
data_wo_stops$articleHeadline = removeWords(data_wo_stops$articleHeadline, stopwords("en"))
data_wo_non_neg_stops$articleHeadline = removeWords(data_wo_non_neg_stops$articleHeadline, stops)

write.csv(data_wo_stops, "headlines_wo_stopwords.csv", row.names = F)
write.csv(data_wo_non_neg_stops, "headlines_wo_no_nneg_stopwords.csv", row.names = F)

term_count <- freq_terms(data_wo_stops$headline, 30)
plot(term_count, main = "Cleaned Headline word frequency")

term_count <- freq_terms(data_wo_stops$claim, 30)
plot(term_count, main = "Cleaned Claim word frequency")

#==================================================================

plot(freq_terms(subset(data, stance == "for")$headline))
plot(freq_terms(subset(data, stance == "against")$headline))
plot(freq_terms(subset(data, stance == "observing")$headline))

plot(freq_terms(subset(data_wo_stops, stance == "for")$headline))
plot(freq_terms(subset(data_wo_stops, stance == "against")$headline))
plot(freq_terms(subset(data_wo_stops, stance == "observing")$headline))




plot(freq_terms(subset(data, stance == "for")$claim))
plot(freq_terms(subset(data, stance == "against")$claim))
plot(freq_terms(subset(data, stance == "observing")$claim))

plot(freq_terms(subset(data_wo_stops, stance == "for")$claim))
plot(freq_terms(subset(data_wo_stops, stance == "against")$claim))
plot(freq_terms(subset(data_wo_stops, stance == "observing")$claim))











