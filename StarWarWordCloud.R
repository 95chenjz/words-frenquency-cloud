# generating Star War word cloud
# testing in R version 3.4.1 (2017-06-30) -- "Single Candle"

library(Hmisc)
library(wordcloud)

# read the file in line by line and merge the lines up 
sw = readLines('StarWar.txt', encoding = 'UTF-8')
#head(sw)
sw_text = unlist(paste(sw, collapse = ' '))

# Eliminate numbers, punctions and any other uselesses, then form the words
#head(sw_text)
sw_text = gsub("[[:digit:]]|[[:punct:]]*愼㸱愼㸱愼㸱愼㸱", "", sw_text, ignore.case = T)
sw_tokens=strsplit(sw_text,"[[:punct:]]+|[[:blank:]]+")
sw_tokens = lapply(sw_tokens, FUN = function(x) x[x!=""])
#head(sw_tokens)

# Calculate the frequency of every word.
tokens = unlist(sw_tokens)
tokens_frequency = table(tokens)
tokens_frequency_percent = table(tokens) / length(tokens)

# Create mask word set to eliminate useless words
mask_word = c('a','able','about','across','after','all','almost','also',
              'am','among','an','and','any','are','as','at','be','because',
              'been','but','by','can','cannot','could','dear','did','do',
              'does','either','else','ever','every','for','from','get','got',
              'had','has','have','he','her','hers','him','his','how','however',
              'i','if','in','into','is','it','its','just','least','let','like',
              'likely','may','me','might','most','must','my','neither','no','nor',
              'not','of','off','often','on','only','or','other','our','own','rather',
              'said','say','says','she','should','since','so','some','than','that',
              'the','their','them','then','there','The','these','they','this','tis','to',
              'too',"twas",'us','wants','was','we','were','what','when',
              'where','which','while','who','whom','why','will','with','would',
              'yet','you','your','S','He','t','S','I','out','s')

# Quantile data to see the most important words
token_50_95 = tokens_frequency[tokens_frequency<quantile(tokens_frequency, 0.9999)&
                               tokens_frequency>quantile(tokens_frequency, 0.98)]
wc = data.frame(freq = as.numeric(token_50_95), words = names(token_50_95))
wc = wc[!wc$words %in% mask_word,]

# Generate the cloud
wordcloud(words = wc$words, freq = wc$freq, max.words = 200, min.freq = 1,
          rot.per = 0.3, random.order = F, colors = brewer.pal(8, 'Dark2'),
          scale = c(5, 0.5))
