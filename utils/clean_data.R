# Read 6 June 2022 data
cal6 <- read_csv("Data/June/calendar.csv.gz")
list6 <- read_csv("Data/June/listings.csv.gz")

# Read 8 September 2021 data
cal9 <- read_csv("Data/September/calendar.csv.gz")
list9 <- read_csv("Data/September/listings.csv.gz")
rev9 <- read_csv("Data/September/reviews.csv.gz")

# Read neighbourhoods data
area <- geojson_read("Data/neighbourhoods.geojson", what = "sp") 

# filter data as of June 6, 2022 and September 9, 2021
cal6a <- cal6 %>%
  filter(date == ymd("20220606"))

cal9a <- cal9 %>%
  filter(date == ymd("20210908"))

# Combine both June and September data into 1 dataset and filter 
cal9_6 <- cal9a %>% bind_rows(cal6a)

# Clean the data and change to suitable data type of the variables
cal <- cal9_6 %>% 
  mutate(price = parse_number(price),
         adjusted_price = parse_number(adjusted_price))

# Removing listing with no price
cal1 <- cal %>% 
  filter(price != 0)

# Subset data for room type
room6 <- list6 %>%
  select(id, room_type) %>%
  group_by(room_type) %>%
  count()

room9 <- list9 %>%
  select(id, room_type) %>%
  group_by(room_type) %>%
  count()

# Cleaning and transforming the comments in the reviews
text_df <- tibble(line = seq_along(rev9$comments), text = rev9$comments)

# split sentences into words
words <- text_df %>% 
  unnest_tokens(output = word,
                input = text,
                token = "words")

# remove the common stopwords, remove </br>, lemmatization of the words
stopwords1 <- get_stopwords(source = "snowball")

words1 <- words %>%
  anti_join(stopwords1) %>%
  filter(word != "br") %>%
  mutate(word = lemmatize_words(word))

# Add sentiments subset the frequent words

sentiments_bing <- get_sentiments("bing")

all_word <- words1 %>%
  inner_join(sentiments_bing) %>%
  count(sentiment, word, sort = TRUE) %>%
  rename("freq" = n) %>%
  arrange(desc(freq)) %>%
  top_n(1000)

positive <- all_word %>%
  filter(sentiment == "positive") %>%
  select(word, freq)

negative <- all_word %>%
  filter(sentiment == "negative") %>%
  select(word, freq)

all <- all_word %>%
  select(word, freq)

