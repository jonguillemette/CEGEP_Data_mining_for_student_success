# This file will use the list of DO found in the DOfinder files and use it to figure things out about them.

load('student_success.RData')

library(data.table)
library(magrittr)
library(knitr)
library(ggplot2)

source('DOfinder.R')
DO<-DOfinder(20103)

#Let's make a DT with all the info about the DOs
#Get the population indicator from admission
#Past schooling from etudes_precedentes
#Gender from etudiant, langue maternelle, postal code?
#Note, COteR from inscription table

DO1<-admission[student_number %in% DO$student_number][,.(student_number,speAdmission,ansessionDebut,ansessionFin,
                                                         TypeAdmission,population)]
#ODD, the number of students I get from this is different than the number of DO I found

nrow(DO1[ansessionDebut==ansessionFin])

#For the inscription table, it gets ugly as there are many IDedtudiantsession related to a single Studentnumber
#Let's start by pulling out all the IDEdutiantSession related to our DOs
IDESDO<-etudiant_session[student_number %in% DO$student_number][,.(student_number,IDEtudiantSession,SPE,
                                                                   TypeFrequentation)]
#I don't lose a single student doing it this way: YAy!

DO2<-inscription[IDEtudiantSession %in% IDESDO$IDEtudiantSession][,.(IDEtudiantSession,Langue,Note,CoteR)]
#I seem to lose a big quantity of people here...

#Need to figure out if for these students during their path they switched from full time to part time to drop.
#Make Sam's states variable again, but with a semester-by-semester path.
