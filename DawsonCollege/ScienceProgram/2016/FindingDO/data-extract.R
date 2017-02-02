rm(list=ls())
library(data.table)
library(magrittr)

etudiant.headers <- c('student_number','date_naissance',
                      'sexe','langue_maternelle','birth_place',
                      'indicateur_deficience',
                      'cote_r','code_postal')
etudiant <-fread("Student Success/Dawson/Etudiant1.txt",sep = ',',
                 col.names = etudiant.headers)


admission.headers <- c('IDAdmission', 'student_number','spe',
                      'speAdmission', 'ansessionDebut',
                      'ansessionFin', 'Withdrawal_date', 
                      'TypeAdmission', 'NoTour','reforme', 
                      'cohorte','population', 
                      'IndicateurReadmission', 'program')
admission <-fread("Student Success/Dawson/Admission.txt",sep = ',',
                 col.names = admission.headers)

etudiant_session.headers<- c('IDEtudiantSession', 'student_number',
                     'program', 'ansession','Etat', 
                     'SPE','TypeFrequentation',
                     'IndicateurCommandite',
                     'IndicateurFinissant', 
                     'IndicateurFinissantCalcule',
                     'Moyenne',
                     'division')
etudiant_session <-fread("Student Success/Dawson/EtudiantSession.txt",sep = ',',
                  col.names = etudiant_session.headers)

cours.headers <- c('IDGroupe', 'course', 
                   'section','PonderationTheo',
                   'PonderationLab','PonderationPersonnel',
                   'Credite', 'SeuilPassageNoteFinale',
                   'NbEtudiantsPremierJourClasse',
                   'NbEtudiantsAuRecensement', 
                   'MoyenneGroupeEvaluation')
cours <-fread("Student Success/Dawson/Cours.txt",sep = ',',
                         col.names = cours.headers)

etudes_precedentes.headers <- c('idEtudeAnterieure','student_number',
                                'EtatEtudeSecondaire','EtatEtudeSecondaireAdulte',
                                'EtatEtudeCollegial','EtatEtudeUniversitaire')
etudes_precedentes <- fread("Student Success/Dawson/EtudesPrecedentes.txt",sep = ",",
                            col.names = etudes_precedentes.headers)

inscription.headers <- c('IDInscription','IDEtudiantSession','IDGroupe','TypeRAF',
                         'ModeEnseignementDistance','Ponderation',
                         'NbAbsences','Langue','MoyenneGroupeEvaluation',
                         'Etat','IndicateurCoursSuivi','IndicateurCoursInscrit',
                         'IndicateurSupprime','DateHeureSynchronisationMinistere',
                         'MoyenneNotesRetenuesCoteR','CodeRemarque','Note','CoteR',
                         'division')
inscription <- fread("Student Success/Dawson/Inscription.txt", sep = ",",
                     col.names = inscription.headers)

student_certification.headers <- c('student_number','IDType',
                                   'ansession','program','division')
student_certification <-fread("Student Success/Dawson/StudentCertification.txt", 
                              col.names = student_certification.headers)

certifcation_type.headers <- c('IDType','numero','titre')
certifcation_type <- fread("Student Success/Dawson/CertificationType.txt",
                           col.names = certifcation_type.headers)
eval_etudiant.headers<-c('student_number','ansession','IdGroupe','MSA')
eval_etudiant <- fread("Student Success/Dawson/EvaluationEtudiant.txt",col.names= eval_etudiant.headers)

save(admission,certifcation_type,cours,etudes_precedentes, etudiant,
     etudiant_session,inscription,student_certification, file = 'student_success.RData')
