library(tidyverse)
library(SnowballC)
library(ggplot2)
library(dplyr)
library(rJava)
library(RColorBrewer)
library(quanteda)
library(wordcloud)
library(doParallel)
library(R.utils)
library(data.table)
library(tm)

# Read txt files and store data
blog = readLines("./en_US.blogs.txt")
news = readLines("./en_US.news.txt")
twitter = readLines("./en_US.twitter.txt")

#split into testing and training sets
sub_b <- sample(length(blog), floor(length(blog) * 0.75))
sub_t <- sample(length(news), floor(length(news) * 0.75))
sub_n <- sample(length(twitter), floor(length(twitter) * 0.75))
training_b <- blog[sub_b]
testing_b <- blog[-sub_b]
training_t <- twitter[sub_t]
testing_t <- twitter[-sub_t]
training_n <- news[sub_n]
testing_n <- news[-sub_n]

# Read the files lines and initialize a character vecor
all_text <- c(training_b, training_t, training_n)

# Create corp us and tokenize
qcorpus <- quanteda::corpus(all_text)

# Free memory
rm(list=setdiff(ls(), "qcorpus"))

# Dictionary of profanity words
badwords<-readLines("http://www.cs.cmu.edu/~biglou/resources/bad-words.txt")

tokenized_corpus <- tokens(qcorpus, what = "word",
                        remove_numbers = TRUE, remove_punct = TRUE,
                        remove_symbols = TRUE, split_hyphens = TRUE,
                        remove_separators = TRUE, remove_url = TRUE)

# Lower case the tokens.
tokenized_corpus <- tokens_tolower(tokenized_corpus)

#Remove profane words
tokenized_corpus <- tokens_remove(tokenized_corpus, badwords)

# Creating N-gram tokens
bigram <- tokens_ngrams(tokenized_corpus, n = 2)
trigram <- tokens_ngrams(tokenized_corpus, n = 3)
fourgram <- tokens_ngrams(tokenized_corpus, n = 4)

# Create Document term matrix
bidtm <- dfm

# Consolidate and save n-grams
n_gram <- rbind(bigram, trigram, fourgram)
write.csv(n_gram, 'en-US_n_gram.csv', row.names=FALSE)

## Create our first DT models
# 1-Grams
uni.dfm <- dfm(tokenized_corpus)
uni.dfmfile <- dfm_trim(uni.dfm, min_docfreq = 10, min_termfreq = 50, verbose = TRUE)
uni.df <- as.data.frame(convert(uni.dfmfile, to = "tripletlist")[2:3])
uni.df <- uni.df %>%
  group_by(feature) %>%
  summarise(frequency = n()) %>%
  arrange(desc(frequency))
#split the word column
ngram1 <- data.frame(do.call('rbind', strsplit(as.character(uni.df$feature),'_',fixed=TRUE)))
names(ngram1) <- c("w1")
ngram1$freq <- uni.df$frequency
rm(uni.dfmfile, uni.dfm,unigram)

# 2-Grams
bi.dfm <- dfm(bigram)
bi.dfmfile <- dfm_trim(bi.dfm, min_docfreq = 2, min_termfreq = 20, verbose = TRUE)
bi.df <- as.data.frame(convert(bi.dfmfile, to = "tripletlist")[2:3])
bi.df <- bi.df %>%
  group_by(feature) %>%
  summarise(frequency = n()) %>%
  arrange(desc(frequency))
#split the word column
ngram2 <- data.frame(do.call('rbind', strsplit(as.character(bi.df$feature),'_',fixed=TRUE)))
names(ngram2) <- c("w1","w2")
ngram2$freq <- bi.df$frequency
rm(bi.dfmfile, bi.dfm,bigram)

# 3-Grams
tri.dfm <- dfm(trigram)
tri.dfmfile <- dfm_trim(tri.dfm, min_docfreq = 2, min_termfreq = 20, verbose = TRUE)
tri.df <- as.data.frame(convert(tri.dfmfile, to = "tripletlist")[2:3])
tri.df <- tri.df %>%
  group_by(feature) %>%
  summarise(frequency = n()) %>%
  arrange(desc(frequency))
#split the word column
ngram3 <- data.frame(do.call('rbind', strsplit(as.character(tri.df$feature),'_',fixed=TRUE)))
names(ngram3) <- c("w1","w2","w3")
ngram3$freq <- tri.df$frequency
rm(tri.dfmfile, tri.dfm, trigram)

# 4-Grams
four.dfm <- dfm(fourgram)
four.dfmfile <- dfm_trim(four.dfm, min_docfreq = 2, min_termfreq = 20, verbose = TRUE)
four.df <- as.data.frame(convert(four.dfmfile, to = "tripletlist")[2:3])
four.df <- four.df %>%
  group_by(feature) %>%
  summarise(frequency = n()) %>%
  arrange(desc(frequency))
#split the word column
ngram4 <- data.frame(do.call('rbind', strsplit(as.character(four.df$feature),'_',fixed=TRUE)))
names(ngram4) <- c("w1","w2","w3","w4")
ngram4$freq <- four.df$frequency
rm(four.dfmfile, four.dfm, fourgram)

#save ngrams as Rdata files for further use.
saveRDS(ngram4, "ngram4.rds")
saveRDS(ngram3, "ngram3.rds")
saveRDS(ngram2, "ngram2.rds")
saveRDS(ngram1, "ngram1.rds")

data4 <- tempfile("ngram4", fileext = ".rds")
data3 <- tempfile("ngram3", fileext = ".rds")
data2 <- tempfile("ngram2", fileext = ".rds")
data1 <- tempfile("ngram1", fileext = ".rds")
ngram4 <- readRDS(data4)
ngram3 <- readRDS(data3)
ngram2 <- readRDS(data2)
ngram1 <- readRDS(data1)
