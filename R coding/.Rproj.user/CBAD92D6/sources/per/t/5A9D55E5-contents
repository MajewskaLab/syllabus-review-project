
###clear all work space
rm(list=ls()) 
graphics.off()

###
require(tidyverse)

syl <- read_csv("data/syllabus-data.csv")

a_SA <- read_csv("data/updated_attendance_SA.csv") %>% 
  rename("AttendPolarity" = "Polarity", "AttendSubjectivity"= "Subjectivity")

g_SA <- read_csv("data/updated_grading_SA.csv") %>% 
  rename("GradingPolarity" = "Polarity", "GradingSubjectivity" = "Subjectivity")

g_LIWC <- read_csv("data/updated_grading_LIWC.csv") 

colnames(g_LIWC) <- paste("Grade_", colnames(g_LIWC), sep = "")

a_LIWC <- read_csv("data/updated_attend_LIWC.csv")

colnames(a_LIWC) <- paste("Attend_", colnames((a_LIWC)), sep = "")

#g_wordcount <- read_csv("data/updated_grading_wordcount.csv")

#a_wordcount <- read_csv("data/updated_attendance_wordcount.csv")

rank <- read_csv("data/rank.csv") %>% 
  select(c(Index, Lead_Instructor, Lead_Rank, Other_Rank))

enroll <- read_csv("data/enrollment.csv") %>% 
  select(c(Index, `Class Size`))

########## merges #

syl2 <- left_join(syl, rank, by = c("Index")) %>%
  left_join(enroll, by = c("Index")) %>%              
  left_join(a_SA, by = c("Attend_File" = "File")) %>% 
  left_join(g_SA, by = c("Grading_File" = "File")) %>% 
  left_join(g_LIWC, by = c("Grading_File" = "Grade_Filename")) %>% 
  left_join(a_LIWC, by = c("Attend_File" = "Attend_Filename"))  


