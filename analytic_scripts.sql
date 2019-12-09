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

SELECT *
FROM diet