
###clear all work space
rm(list=ls()) 
graphics.off()

###
require(tidyverse)

#import data
syl <- read_csv("data/syllabus-data.csv")

ton <- read_csv("data/tone_validation.csv") 

syl2 <- syl %>% 
  mutate(gradingtext = factor(Grading_File)) %>% 
  select(c("gradingtext","GradeTone1", "GradeTone1scale", "GradeTone2", "GradeTone2scale"))

ton1 <- ton %>% 
  mutate(gradingtext = factor(Statement)) %>% 
  group_by(gradingtext) %>% 
  count(tone1)

ts <- left_join(ton1, syl2, by = c("gradingtext")) %>% 
  mutate(match = case_match(tone1,GradeTone1 ~ "match"), Prop = n/5) %>% 
  filter(match == "match")

ton2 <- ton %>% 
  mutate(gradingtext = factor(Statement)) %>% 
  group_by(gradingtext) %>% 
  count(tone2)

ts2 <- left_join(ton2, syl2, by = c("gradingtext")) %>% 
  mutate(match = case_match(tone2,GradeTone1 ~ "match"), Prop2 = n/5) %>% 
  filter(match == "match")


library(hrbrthemes)

ts %>% 
  ggplot(aes(x=Prop)) + 
  geom_histogram(binwidth=.1, fill="#69b3a2", color="#e9ecef", alpha=0.9)+
  ggtitle("Tone 1") +
  theme_classic()+
  scale_y_continuous(expand = c(0,0))

ts2 %>% 
  ggplot(aes(x=Prop2)) + 
  geom_histogram(binwidth=.1, fill="orange", color="#e9ecef", alpha=0.9)+
  ggtitle("Tone 2") +
  theme_classic()+
  scale_y_continuous(expand = c(0,0))

#####################


ton1pos <- ton %>% 
  mutate(gradingtext = factor(Statement)) %>% 
  group_by(gradingtext) %>% 
  summarize(posit= mean(`positivity rating`), posmedian = median(`positivity rating`))
