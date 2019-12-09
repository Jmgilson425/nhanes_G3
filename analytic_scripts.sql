/* How many patients are being treated for Type 2 Diabetes? */

SELECT COUNT(patient_id) AS diabetes_patients, (SELECT COUNT(patient_id) FROM patients) AS all_patients
FROM patients p
WHERE patient_id IN (	SELECT patient_id 
						FROM prescription_reasons 
						WHERE reason_for_prescription ILIKE '%Type 2 Diabetes%' );
						


						
/* What are the most commonly prescribed medications for patients with Type 2 Diabetes */

SELECT *
FROM (SELECT medication_id, COUNT(*) 
	  FROM prescription_reasons p 
	  WHERE reason_for_prescription ILIKE '%Type 2 Diabetes%'
	  GROUP BY medication_id) AS prescription_count
NATURAL JOIN medications
ORDER BY count DESC




/* What is the average mg of Sodium (diet_types: DR1TSODI) consumed by patients with Type 2 Diabetes? */

SELECT AVG(value)
FROM diet
WHERE diet_id = 'DR1TSODI'
AND patient_id IN (SELECT patient_id 
				   FROM prescription_reasons 
				   WHERE reason_for_prescription ILIKE '%Type 2 Diabetes%');




/* What is the income level for patients who are being treated for diabetes */

select p.patient_id,i.income_value 
from income_lookup as i left join patients as p on i.income_id=p.income_id  
where p.patient_id in (select patient_id from prescription_reasons where  reason_for_prescription LIKE 'Type 2 diabetes%' )
order by i.income_id




/* What’s the ethnicity of patients who have diabetes? */

select el.ethnicity_value,count(el.ethnicity_id)
from ethnicity_lookup el join patients on el.ethnicity_id= patients.ethnicity_id
join prescription_reasons pr on patients.patient_id= pr.patient_id
where reason_for_prescription ilike '%type 2 diabetes%'
group by el.ethnicity_id




/* What are the names and values of all examination information for patient 75262? */

SELECT examination_id, examination_name, value 
FROM examinations NATURAL JOIN examination_types
WHERE patient_id = 75262
