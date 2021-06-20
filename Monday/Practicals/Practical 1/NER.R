df <- data.frame(id = c(1, 2), 
                 text = c("My best friend John works at Google.", 
                          "However he would like to work at Amazon as he likes to use Python and stay in Canada."),
                 stringsAsFactors = FALSE)

library("spacyr")
library("dplyr")

# -- need to do these before the next function will work:
# spacy_install()
# spacy_download_langmodel(model = "en_core_web_lg")

spacy_initialize(model = "en_core_web_lg")
#> Found 'spacy_condaenv'. spacyr will use this environment
#> successfully initialized (spaCy Version: 2.0.10, language model: en_core_web_lg)
#> (python options: type = "condaenv", value = "spacy_condaenv")

txt <- df$text
names(txt) <- df$id

spacy_parse(txt, lemma = FALSE, entity = TRUE) %>%
  entity_extract() %>%
  group_by(doc_id) %>%
  summarize(ner_words = paste(entity, collapse = ", "))
#> # A tibble: 2 x 2
#>   doc_id ner_words             
#>   <chr>  <chr>                 
#> 1 1      John, Google          
#> 2 2      Amazon, Python, Canada