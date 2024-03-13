
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

all_LIWC <- read_csv("data/updated_LIWC_all_text.csv")

colnames(all_LIWC) <- paste("All_", colnames((all_LIWC)), sep = "")

all_LIWC <- all_LIWC %>% 
  separate(All_Filename, into = c("x", "y"), sep = "-INDEX-") %>%  
  separate(y, into = c("Index"), sep = ".txt") %>% 
  select(-c("x"))

all_LIWC$Index <- as.numeric(all_LIWC$Index)
  



#g_wordcount <- read_csv("data/updated_grading_wordcount.csv")

#a_wordcount <- read_csv("data/updated_attendance_wordcount.csv")

rank <- read_csv("data/rank.csv") %>% 
  select(c(Index, Lead_Instructor, Lead_Rank2,Lead_Track, Other_Rank2, Other_Track))

enroll <- read_csv("data/enrollment.csv") %>% 
  select(c(Index, `Class Size`)) %>% 
  rename("Class_Size" = `Class Size`)


########## merges #

syl2 <- left_join(syl, rank, by = c("Index")) %>%
  left_join(enroll, by = c("Index")) %>%              
  left_join(a_SA, by = c("Attend_File" = "File")) %>% 
  left_join(g_SA, by = c("Grading_File" = "File")) %>% 
  left_join(g_LIWC, by = c("Grading_File" = "Grade_Filename")) %>% 
  left_join(a_LIWC, by = c("Attend_File" = "Attend_Filename")) %>% 
  left_join(all_LIWC, by = c("Index")) %>% 
  mutate(Class_Size_Cat = case_when(Class_Size > 100 ~ "large", 
                                    between(Class_Size, 31, 99)  ~ "medium",
                                    between(Class_Size, 1, 30)  ~ "small",
                                    TRUE ~ "NA")) %>% 
  rename("Last_Name" = `Last Name`)

write.csv(syl2, "data/masterDF.csv")
