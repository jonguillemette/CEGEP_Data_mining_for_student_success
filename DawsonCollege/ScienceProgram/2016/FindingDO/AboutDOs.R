# This file will use the list of DO found in the DOfinder files and use it to figure things out about them.


#Can you finish cegep without graduating: is there any state in which this is possible? Just took 1 class to get into
#some program at Uni? 

load('student_success.RData')

library(data.table)
library(magrittr)
library(knitr)
library(ggplot2)

source('DOfinder.R')
DO<-DOfinder(20103)
#All my DO's are unique and come from the previous file.

#Let's make a DT with all the info about the DOs
#Get the population indicator from admission
#Past schooling from etudes_precedentes
#Gender from etudiant, langue maternelle, postal code?
#Note, COteR from inscription table

#Start fresh by looking at the SO status for many of the DOs. The hunch is that MANY people DO without ever registering
#for a single class meaning that they would show up in admission, but not in inscription. 
#this may be as large as HALF the DOs ever admitted by the college. 

#Leftout<- DO[student_number %NI% DO1$student_number]
#This gives 15k students who are in the DOfinder list, but NOT the admission's table.  
#Correct<-DO[student_number %NI% Leftout$student_number]
#This is the unique number of students who are in the DOlis and in the admissions table. 

DO1<-admission[student_number %in% DO$student_number][population=="A"][,.(student_number,speAdmission,ansessionDebut,ansessionFin,
                                                         TypeAdmission,population)]
#length(unique(DO1$student_number))
#20651
#length(DO1$student_number)
#26945
#There are 6k doublets in the DO1 table Who are they?
#This means that there are 6k students who have DO at least once (maybe twice) and also come back at least once.

doublets<-DO1[,.SD,by=student_number][duplicated(DO1,by="student_number")]

#I also want to know who is in DO, but not in admissions...
Leftout<- DO[student_number %NI% admission$student_number]
length(unique(Leftout$student_number))
#15313
DOstat<- etudiant_session[student_number %in% Leftout$student_number][,.(student_number,TypeFrequentation,ansession,IDEtudiantSession)]
DOstat[,.N, by=TypeFrequentation]
#These people mostly (15629) have SO as a type de frequentation. 
#Has anyone with SO as frequentation ever graduated?
gradcheck<- etudiant_session[student_number %in% student_certification$student_number][,.(student_number,TypeFrequentation)]
#Something weird with the SOs. MANY students have them:
length(unique(gradcheck$student_number[which(gradcheck$TypeFrequentation=="SO")]))
#17817
length(unique(gradcheck$student_number))
#28349
#Find the number of DO who have only 1 semester in the college with SO as their status. 
#There are 167k lines to grad check (because they all show up a fuck ton of times (many classes) with 28k unique stus
#There are 15k lines to DOstat and 15k uniques because they all only took 1 class (if that...)

#The source of the SO may be that 


#There are 10k people who were re-admitted! (readmission ==1)

#nrow(DO1[ansessionDebut==ansessionFin])
#1300

#For the inscription table, it gets ugly as there are many IDedtudiantsession related to a single Studentnumber
#Let's start by pulling out all the IDEdutiantSession related to our DOs
IDESDO<-etudiant_session[student_number %in% DO$student_number][,.(student_number,IDEtudiantSession,SPE,
                                                                   TypeFrequentation)]
#IDESDO[,.N,by=student_number][N==1]
#15k DOs took only 1 class!!!!!
#I don't lose a single student doing it this way: YAy! My 36k DOs have 128k classes.
#Weird that only 1300 students (from nrowDO1) have stayed only 1 semester, but I have 15k classes. I would expect people
#who have only taken 1 class to have only stayed 1 semester... So unless they are taking 10 classes...

DO2<-inscription[IDEtudiantSession %in% IDESDO$IDEtudiantSession][,.(IDEtudiantSession,Langue,Note,CoteR)]

#I seem to lose a big quantity of people here... who are they and why am I losing them?
#length(unique(DO2$IDEtudiantSession))
#82710 compared to 128k.

#Who shows up in IDESDO but that doesn't show up in inscription?
leftout2<- IDESDO[IDEtudiantSession %NI% inscription$IDEtudiantSession]

#Figure out if the 1319 students who have the same start and fininsh registered for many classes?

#Need to figure out if for these students during their path they switched from full time to part time to drop.
#Make Sam's states variable again, but with a semester-by-semester path.
