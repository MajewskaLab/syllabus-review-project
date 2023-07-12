###
require(tidyverse)


AttendSA <- read_csv("AttendSA.csv")

syl <- read_csv("syllabus-data.csv")


df<-left_join(syl, AttendSA, by = c("Attend_File" = "File")) %>% 
  mutate(courseID = paste0(Department_Code, Course_Number))

df2 <- df %>% distinct(courseID, .keep_all=TRUE)

tiff("Fig1.tiff",width=7,height=3,units="in",res=300)
df2 %>% 
  filter(!is.na(Year)) %>% 
  ggplot(aes(x = factor(Year), y = Polarity)) +
  geom_point()+
  geom_boxplot(fill = "#bdd7e7")+
  theme_classic()+
  labs(y = "Polarity", x = "")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))
dev.off()

tiff("Fig2.tiff",width=7,height=3,units="in",res=300)
df2 %>% 
  filter(!is.na(Year)) %>% 
  ggplot(aes(x = factor(Year), y = Subjectivity)) +
  geom_point()+
  geom_boxplot(fill = "#ffffb2")+
  theme_classic()+
  labs(y = "Subjectivity", x = "")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))
dev.off()

df3<-df2 %>% 
  filter(!is.na(AttendTone1)) %>% 
  group_by(AttendTone1) %>% 
  summarize(n=n())

df4<-df2 %>% 
  filter(!is.na(GradeTone1)) %>% 
  group_by(GradeTone1) %>% 
  summarize(n=n())

tiff("Fig3.tiff",width=8,height=3,units="in",res=300)
df3 %>% 
  ggplot(aes(x = AttendTone1, y = n, fill = AttendTone1))+
  geom_bar(stat="identity", width =  0.5)+
  theme_classic()+
  labs(y = "Count", x = "Tone")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12), 
        legend.position = "none")+
          scale_y_continuous(expand = c(0,0))+
  scale_fill_manual(values = c('#a6cee3','#1f78b4','#b2df8a','#33a02c','#fb9a99','#e31a1c','#fdbf6f','#ff7f00','#cab2d6'))
dev.off()

tiff("Fig4.tiff",width=8,height=3,units="in",res=300)
df4 %>% 
  ggplot(aes(x = GradeTone1, y = n, fill = GradeTone1))+
  geom_bar(stat="identity", width =  0.5)+
  theme_classic()+
  labs(y = "Count", x = "Tone")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12), 
        legend.position = "none")+
  scale_y_continuous(expand = c(0,0), breaks=c(0,2,4,6,8,10,12,14))+
  scale_fill_manual(values = c('#fccde5', '#33a02c','#e31a1c','#ff7f00','#ffffb3','#cab2d6'))
dev.off()