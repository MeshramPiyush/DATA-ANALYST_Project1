use Healthcare;
-- creating Table - Diagnosis ,Patients ,Outcomes, Labs

create table Diagnosis(
DiagnosisId Int primary Key,
DiagnosisName varchar(255)
);

create table Outcomes(
OutcomeId Int Primary key,
OutcomeName varchar(255)
);

create table Patients(
PatientId int primary key,
Name varchar(255),
Age int,
Gender char(1),
DiagnosisId int,
AdmissionDate Date,
DischargeDate date,
OutcomeId int,
TreatmentCost decimal(10,2),
foreign key (DiagnosisId) references Diagnosis(DiagnosisId),
foreign key (OutcomeId) references Outcomes(OutcomeId)
);

create table Labs(
LabId int primary key,
PatientId int,
TestName varchar(255),
Result decimal(10,2),
NormalRange varchar(255),
foreign key (PatientId) references Patients(PatientId)
);


select * from Diagnosis;
select * from Labs;
select * from Patients;
select * from Outcomes;

-- Retreiving Detailed Patient Lab History

select p.PatientId ,p.Name ,d.DiagnosisName,o.OutcomeName,l.TestName, l.Result,l.NormalRange
from Patients p
join Diagnosis d on p.DiagnosisId = d.DiagnosisId
join Outcomes o on p.OutcomeId = o.OutcomeId
join Labs l on p.PatientId = l.PatientId
order by p.PatientId,l.TestName;

-- Average Lab results By Diagnosis

select d.DiagnosisName ,l.Testname ,avg(l.Result) as AvgResult
from Patients p
join Diagnosis d on p.DiagnosisId = d.DiagnosisId
join Labs l on p.PatientId = l.PatientId
group by  l.Testname,d.DiagnosisName;

-- Count Of Abnormal Lab Results

select p.PatientId ,p.Name, count(*) as AbnormalCount
from Patients p
join Labs l on p.PatientId = l.PatientId
where (l.TestName = 'Cholestrol' and l.Result >200)  or
(l.TestName ='Blood Sugar' and l.Result>120) or 
(l.TestName = 'Hemoglobin' and l.Result<13) 
group by p.PatientId ,p.Name
order by AbnormalCount desc;

-- Diagnosis with Highest Treatment Cost 

select  d.DiagnosisName,sum(p.TreatmentCost) as TotalCost
from Patients p
join Diagnosis d on p.DiagnosisId = d.DiagnosisId
group by  d.DiagnosisName 
order by TotalCost desc;


--  Patients at Risk by their Age and Gender
 select p.PatientId,p.name ,p.age,p.gender,d.diagnosisname ,o.OutcomeName					
 from Patients p
 join Outcomes o on p.OutcomeId = o.OutcomeId
 join Diagnosis d on p.DiagnosisId = d.DiagnosisId
 where p.Age >65 and o.outcomename != 'Recovered';


 -- Lab Trends over time for Specific Patient

 select l.testname ,l.result ,p.admissiondate
 from Labs l
 join Patients p on l.PatientId = p.PatientId
 where p.PatientId in (2,4,6,8,10,12)
 order by AdmissionDate;


 -- distribution of outcomes by diagnosis
 select d.diagnosisname ,o.outcomename ,count(*) as Outcomecount
 from Patients p
 join Diagnosis d on p.DiagnosisId = d.DiagnosisId
 join Outcomes o on p.OutcomeId = o.OutcomeId
 group by d.diagnosisname ,o.outcomename
 order by d.diagnosisname ,o.outcomename desc;
