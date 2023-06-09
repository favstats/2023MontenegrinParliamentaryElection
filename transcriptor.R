
library(tidyverse)

all_transcripts <- dir("../../../../Downloads/transcripts-by-year/by-year", full.names = T, recursive = T) %>% 
  .[3001:length(.)] %>%
  map_dfr_progress(
    ~{
      jsonlite::fromJSON(.x) %>% 
        pluck("results") %>% 
        pluck("alternatives")%>% 
        bind_rows() %>% 
        as_tibble() %>% 
        # select(-word) %>% 
        mutate(path = .x)
      
    }
  )
  
saveRDS(all_transcripts, "all_transcripts7.rds")


transsripts <- dir() %>% 
  keep(~str_detect(.x, "transcripts")) %>% 
  map_dfr(readRDS) %>% 
  distinct()
