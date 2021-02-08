## Introduction

This report represents the initial analysis and scope of a project to create a text prediction application. The corporate partner for this project is SwiftKey, which builds a smart keyboard that makes it easier for people to type on their mobile devices.

## Readme

NLP is a complex and biased challenge.

Because the developer was unfamiliar with the NLP, web resources about the product were read.
This included [Text Mining Infrastructure in R](https://www.jstatsoft.org/article/view/v025i05), [CRAN Task View: Natural Language Processing](https://cran.r-project.org/web/views/NaturalLanguageProcessing.html), and [Slides from the Stanford Natural Language Processing Course](https://web.stanford.edu/~jurafsky/NLPCourseraSlides.html). This information was extremely useful but, at some points, quite intimidating for a developer new to text mining and natural language processing. For some topics, more basic knowledge was sought. Tholoshon Nagarajah’s [Build Your Own Word/Sentence Predication Application](https://thiloshon.wordpress.com/2018/02/11/build-your-own-word-sentence-prediction-application-part-01-theory) proved particularly helpful for theoretical considerations. For file manipulation, [Open Source Automation’s R: How To Create, Delete, Move, and More With Files](http://theautomatic.net/2018/07/11/manipulate-files-r/) was extremely helpful.

## Data

The data was pulled from the following [Dataset](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip) and selected from the en_US folder. Each `txt` file was then sampled to reduce the computation power but mantaining the scope integrity of the assignment.

## Corpus

The vector of the sampled character vector, from all the `txt` files, is then pulled together into a corpus object and cleaned of all puctuations, white spaces, numbers, caps and special characters. This allows the tokenization to be afficent and relevant for our n-gram explorative analysis. Some challenges were faced during this phase due to further incompatibilities with the n-gram tokenization, hence, a function for character object scope is passed through all the `corpus` text mining mapping to avoid later errors. Discovered at later stage that the package [Quanteda](https://quanteda.io/) can provide a faster and more compatible word tokenization. For this report the package [tm](https://cran.r-project.org/web/packages/tm/tm.pdf) and [RWeka](https://cran.r-project.org/web/packages/RWeka/RWeka.pdf) were used

## Tokenization

The sampled corpus was broken down in unigrams, bigrams and trigrams and ordered by frequency. However, to fully explot the power of the word prediction, is advised to adopt the full dataset of 3M+ sentences. This will require further computational power and maybe RStudio cloud version will be adopted.
