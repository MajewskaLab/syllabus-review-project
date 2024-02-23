###
###clear all work space
rm(list=ls()) 
graphics.off()

require(tidyverse)


#import data
syl <- read_csv("data/masterDF.csv") %>% 
  filter(Department_Code != "PSYC") 

syl$Class_Size_Cat<-factor(syl$Class_Size_Cat, levels = c("small", "medium", "large"), labels = c("small", "medium", "large"))

df<-syl %>% 
  group_by(Lead_Rank2, GradeTone1) %>% 
  count(total=n()) %>% 
  filter(!is.na(GradeTone1)) %>% 
  filter(Lead_Rank2 %in% c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR", "Dean Chair Director","LECTURER"))

df$Lead_Rank2<-factor(df$Lead_Rank2, levels = c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR","Dean Chair Director","LECTURER"), labels = c("Asst. Professor", "Assoc. Professor", "Full Professor", "Dean Chair Director","Lecturer"))

df %>% 
ggplot(aes(y=GradeTone1, x=Lead_Rank2, size = n)) +
  geom_point(alpha=0.5) +
  scale_size_continuous("Count", range = c(1, 20)) +
  geom_text(aes(label = n), size = 4) +
theme_minimal(base_size = 5 * .pt)
 
#summary(glm(GradeTone1 ~ Lead_Rank2, data = syl))

df2<-syl %>% 
  group_by(Lead_Track, GradeTone1) %>% 
  count(total=n()) %>% 
  filter(!is.na(GradeTone1)) %>% 
  filter(!is.na(Lead_Track))
  
df2 %>% 
  ggplot(aes(y=GradeTone1, x=Lead_Track, size = n )) +
  geom_point(alpha=0.5) +
  scale_size_continuous("Count", range = c(1, 20)) +
  geom_text(aes(label = n), size = 4) +
  theme_minimal(base_size = 5 * .pt)


syl %>% 
  group_by(Class_Size_Cat, GradeTone1) %>% 
  count(total=n()) %>% 
  filter(!is.na(GradeTone1)) %>% 
  filter(!is.na(Class_Size_Cat)) %>% 
ggplot(aes(y=GradeTone1, x=Class_Size_Cat, size = n)) +
  geom_point(alpha=0.5) +
  scale_size_continuous("Count", range = c(1, 20)) +
  geom_text(aes(label = n), size = 4) +
  theme_minimal(base_size = 5 * .pt)

 

####################################################################


df1<-syl %>% 
  group_by(Lead_Rank2, AttendTone1) %>% 
  count(total=n()) %>% 
  filter(!is.na(AttendTone1)) %>% 
  filter(Lead_Rank2 %in% c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR", "Dean Chair Director","LECTURER"))

df1$Lead_Rank2<-factor(df1$Lead_Rank2, levels = c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR","Dean Chair Director","LECTURER"), labels = c("Asst. Professor", "Assoc. Professor", "Full Professor", "Dean Chair Director","Lecturer"))

df1 %>% 
  ggplot(aes(y=AttendTone1, x=Lead_Rank2, size = n)) +
  geom_point(alpha=0.5) +
  scale_size_continuous("Count", range = c(1, 20)) +
  geom_text(aes(label = n), size = 4) +
  theme_minimal(base_size = 5 * .pt)

df3<-syl %>% 
  group_by(Lead_Track, AttendTone1) %>% 
  count(total=n()) %>% 
  filter(!is.na(AttendTone1)) %>% 
  filter(!is.na(Lead_Track))

df3 %>% 
  ggplot(aes(y=AttendTone1, x=Lead_Track, size = n )) +
  geom_point(alpha=0.5) +
  scale_size_continuous("Count", range = c(1, 20)) +
  geom_text(aes(label = n), size = 4) +
  theme_minimal(base_size = 5 * .pt)


syl %>% 
  group_by(Class_Size_Cat, AttendTone1) %>% 
  count(total=n()) %>% 
  filter(!is.na(AttendTone1)) %>% 
  filter(!is.na(Class_Size_Cat)) %>% 
  ggplot(aes(y=AttendTone1, x=Class_Size_Cat, size = n)) +
  geom_point(alpha=0.5) +
  scale_size_continuous("Count", range = c(1, 20)) +
  geom_text(aes(label = n), size = 4) +
  theme_minimal(base_size = 5 * .pt)




####################################################################




syl %>% 
  filter(!is.na(Year)) %>% 
  group_by(Year) %>% 
  summarize(count = n()) %>% 
  ggplot(aes(x = factor(Year), y = count)) +
  geom_bar(stat="identity")+
  theme_classic()+
  labs(y = "Count of syllabi", x = "Year")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))+ 
  scale_y_continuous(expand = c(0,0))


syl %>% 
  filter(!is.na(Year)) %>%  
  group_by(Year, Learning_Outcomes_Present) %>% 
  count(total = n()) %>% 
  filter(Learning_Outcomes_Present=="Yes") %>% 
  ggplot(aes(x = factor(Year), y = n)) +
  geom_bar(stat="identity")+
  theme_classic()+
  labs(y = "Syllabi with LOs", x = "Year")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))+ 
  scale_y_continuous(expand = c(0,0))


syl %>% 
  filter(!is.na(Year)) %>% 
  group_by(Year, DEI_Statement_Present) %>% 
  summarize(count = n()) %>% 
  filter(DEI_Statement_Present=="Yes") %>% 
  ggplot(aes(x = factor(Year), y = count)) +
  geom_bar(stat="identity")+
  theme_classic()+
  labs(y = "Count of syllabi with diversity statements", x = "Year")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))+ 
  scale_y_continuous(expand = c(0,0))

  



syl %>% 
  filter(!is.na(Year)) %>% 
  #filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Year), y = GradingPolarity)) +
  geom_boxplot(fill = "#bdd7e7")+
  geom_point()+
   theme_classic()+
  labs(y = "Polarity", x = "")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))


syl %>% 
  filter(!is.na(Year)) %>% 
  filter(Lead_Rank2 %in% c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR", "Dean Chair Director","LECTURER")) %>% 
#filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Lead_Rank2), y = GradingPolarity)) +
  geom_boxplot(fill = "#bdd7e7")+
  geom_point()+
  theme_classic()
  
syl %>% 
  filter(!is.na(Year)) %>% 
  filter(Lead_Rank2 %in% c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR", "Dean Chair Director","LECTURER")) %>%  #filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Lead_Rank2), y = AttendPolarity)) +
  geom_boxplot(fill = "orange")+
  geom_point()+
  theme_classic()

syl %>% 
  filter(!is.na(Year)) %>% 
  filter(Lead_Rank2 %in% c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR", "Dean Chair Director","LECTURER")) %>%  #filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Lead_Rank2), y = GradingSubjectivity)) +
  geom_boxplot(fill = "blue")+
  geom_point()+
  theme_classic()

syl %>% 
  filter(!is.na(Year)) %>% 
  filter(Lead_Rank2 %in% c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR", "Dean Chair Director","LECTURER")) %>%  #filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Lead_Rank2), y = AttendSubjectivity)) +
  geom_boxplot(fill = "yellow")+
  geom_point()+
  theme_classic()


#`````````````````````````````````````````````


syl %>% 
  filter(!is.na(Year)) %>% 
  filter(!is.na(Lead_Track)) %>% 
    #filter(Lead_Rank2 %in% c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR","LECTURER")) %>% 
  #filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Lead_Track), y = GradingPolarity)) +
  geom_boxplot(fill = "#bdd7e7")+
  geom_point()+
  theme_classic()

syl %>% 
  filter(!is.na(Year)) %>% 
  filter(!is.na(Lead_Track)) %>% 
 # filter(Lead_Rank2 %in% c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR","LECTURER")) %>% 
  #filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Lead_Track), y = AttendPolarity)) +
  geom_boxplot(fill = "orange")+
  geom_point()+
  theme_classic()

syl %>% 
  filter(!is.na(Year)) %>% 
  filter(!is.na(Lead_Track)) %>% 
  #filter(Lead_Rank2 %in% c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR","LECTURER")) %>% 
  #filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Lead_Track), y = GradingSubjectivity)) +
  geom_boxplot(fill = "#bdd7e7")+
  geom_point()+
  theme_classic()

syl %>% 
  filter(!is.na(Year)) %>% 
  filter(!is.na(Lead_Track)) %>% 
  # filter(Lead_Rank2 %in% c("ASSISTANT PROFESSOR","ASSOCIATE PROFESSOR","PROFESSOR","LECTURER")) %>% 
  #filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Lead_Track), y = AttendSubjectivity)) +
  geom_boxplot(fill = "orange")+
  geom_point()+
  theme_classic()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

df4 %>% 
  filter(!is.na(Year)) %>% 
  #filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Year), y = Subjectivity)) +
  geom_boxplot(fill = "#ffffb2")+
  geom_point()+
  theme_classic()+
  labs(y = "Subjectivity", x = "")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))

####


df4 %>% 
  filter(!is.na(Year)) %>% 
  filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Year), y = Polarity)) +
  geom_boxplot(fill = "#bdd7e7")+
  geom_point()+
  theme_classic()+
  labs(y = "Polarity", x = "")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))



df4 %>% 
  filter(!is.na(Year)) %>% 
  filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = factor(Year), y = Subjectivity)) +
  geom_boxplot(fill = "#ffffb2")+
  geom_point()+
  theme_classic()+
  labs(y = "Subjectivity", x = "")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))




df4 %>% 
  filter(!is.na(Year)) %>% 
  filter(Department_Code=="BIOL") %>% 
  filter()
ggplot(aes(x = factor(Year), y = Polarity)) +
  geom_boxplot(fill = "#bdd7e7")+
  geom_point()+
  theme_classic()+
  labs(y = "Polarity", x = "")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))


####
syl %>% 
  filter(!is.na(Year)) %>% 
#  filter(AttendWordCount<300) %>% 
 # filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = Attend_WC, y = Class_Size)) +
  geom_point()+
 geom_smooth(method = "lm",se = F)+
  theme_classic()+
  labs(y = "Class Size", x = "Attendance Policy Word Count")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))

syl %>%  
  #filter(!is.na(Year)) %>% 
  #  filter(AttendWordCount<300) %>% 
  # filter(Course_Number_Suffix =="L") %>% 
  ggplot(aes(y = Attend_WC, x = Class_Size,color = Division)) +
  geom_point()+
  geom_smooth(method = "lm",se = F)+
  theme_classic()+
  labs(x = "Class Size", y = "Attendance Policy Word Count")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))

syl %>% 
  #filter(!is.na(Year)) %>% 
 # filter(GradingWordCount<400) %>% 
  # filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = Grade_WC, y = Class_Size, color = Division)) +
  geom_point()+
  geom_smooth(method = "lm", se = F)+
  theme_classic()+
  labs(y = "Class Size", x = "Grading Policy Word Count")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))


syl %>% 
  #filter(!is.na(Year)) %>% 
 # filter(GradingWordCount<400) %>% 
  # filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = Grade_WC, y = Class_Size, color = Division)) +
  geom_point()+
  geom_smooth(method = "lm", se = F)+
  theme_classic()+
  labs(y = "Class Size", x = "Grading Policy Word Count")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))

# word count and ranking 


#tiff("Fig3_pol_wordattend.tiff",width=7,height=3,units="in",res=300)
syl %>% 
  #filter(!is.na(Year)) %>% 
 # filter(GradingWordCount<400) %>% 
  # filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = Attend_WC, y = `AttendPolarity`, color = Division)) +
  geom_point()+
  geom_smooth(method = "lm", se = F)+
  theme_classic()+
  labs(x = "Class Size", y = "Polarity")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))
#dev.off()


#tiff("Fig3_sub_wordattend.tiff",width=7,height=3,units="in",res=300)
syl %>% 
  #filter(!is.na(Year)) %>% 
  # filter(AttendanceWordCount<400) %>% 
  # filter(Department_Code=="BIOL") %>% 
  ggplot(aes(x = Attend_WC, y = AttendSubjectivity, color = Division)) +
  geom_point()+
  geom_smooth(method = "lm", se = F)+
  theme_classic()+
  labs(x = "Attendance Policy Word Count", y = "Subjectivity")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))
dev.off()

df5<-df4 %>% 
  filter(!is.na(AttendTone1)) %>% 
  mutate(AttendTone1 = tolower(AttendTone1)) %>% 
  group_by(AttendTone1) %>% 
  summarize(n=n(), meanPol = mean(Polarity, na.rm = T), meanSub = mean(Subjectivity, na.rm = T))

df6<-df4 %>% 
  filter(!is.na(GradeTone1)) %>% 
  mutate(GradeTone1 = tolower(GradeTone1)) %>% 
  group_by(GradeTone1) %>% 
  summarize(n=n())

tiff("Fig3_Attendtones.tiff",width=8,height=3,units="in",res=300)
df5 %>% 
  ggplot(aes(x = AttendTone1, y = n, fill = AttendTone1))+
  geom_bar(stat="identity", width =  0.5)+
  theme_classic()+
  labs(y = "Count", x = "Tone of Attendance Policy")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12), 
        legend.position = "none")+
          scale_y_continuous(expand = c(0,0))+
  scale_fill_manual(values = c( "gray",'#a6cee3','#1f78b4','#b2df8a','#33a02c','#fb9a99','#e31a1c','#fdbf6f','#ff7f00','#cab2d6'))
dev.off()


tiff("Fig4_tonesgrade.tiff",width=8,height=3,units="in",res=300)
df6 %>% 
  #filter(!is.na(SizeCategory)) %>% 
  ggplot(aes(x = GradeTone1, y = n, fill = GradeTone1))+
  geom_bar(stat="identity", width =  0.5)+
  theme_classic()+
  labs(x = "Grading Policy Tone", y = "Count")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12),   legend.position = "none")+
  scale_y_continuous(expand = c(0,0))+
  scale_fill_manual(values = c("black","gray",'#a6cee3','#1f78b4','#e31a1c','#fdbf6f','#cab2d6','#ff7f00', "yellow"))
dev.off()

df7<-df4 %>% 
  filter(!is.na(AttendTone1)) %>% 
  mutate(AttendTone1 = tolower(AttendTone1)) %>% 
  group_by(AttendTone1, SizeCategory) %>% 
  summarize(n=n())

df8<-df4 %>% 
  filter(!is.na(GradeTone1)) %>% 
  mutate(GradeTone1 = tolower(GradeTone1)) %>% 
  group_by(GradeTone1, SizeCategory) %>% 
  summarize(n=n())

tiff("Fig4_sizeandattendTone.tiff",width=8,height=3,units="in",res=300)
df7 %>% 
  filter(!is.na(SizeCategory)) %>% 
  ggplot(aes(x = SizeCategory, y = n, fill = AttendTone1))+
  geom_bar(stat="identity", width =  0.5)+
  theme_classic()+
  labs(y = "Count", x = "Class size")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))+
  scale_y_continuous(expand = c(0,0))+
  scale_fill_manual(values = c("gray",'#a6cee3','#1f78b4','#b2df8a','#33a02c','#fb9a99','#e31a1c','#fdbf6f','#ff7f00','#cab2d6'))
dev.off()



tiff("Fig4_sizeandtonesgrade.tiff",width=8,height=3,units="in",res=300)
df8 %>% 
  filter(!is.na(SizeCategory)) %>% 
  ggplot(aes(x = SizeCategory, y = n, fill = GradeTone1))+
  geom_bar(stat="identity", width =  0.5)+
  theme_classic()+
  labs(y = "Count", x = "Class Size")+
  theme(axis.text=element_text(size=12),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12),
        axis.text.x = element_text(size=10),
        axis.text.y = element_text(size=12),
        legend.text = element_text(size=12),
        legend.title = element_text(size=12))+
  scale_y_continuous(expand = c(0,0))+
  scale_fill_manual(values = c("black","gray",'#a6cee3','#1f78b4','#e31a1c','#fdbf6f','#cab2d6','#ff7f00', "yellow"))
dev.off()





library(PerformanceAnalytics)

chart.Correlation(Data.num,
                  method="spearman",
                  histogram=TRUE,
                  pch=16)