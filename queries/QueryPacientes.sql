SELECT DISTINCT
Pacientes.Apellidos AS 'Paciente',Pacientes.Edad, Pacientes.Mutacion_Efecto_Fenotipo AS 'Enfermedad', Pacientes.Mutacion_Gen_ID AS ' ID Gen afectado'

FROM  Pacientes
WHERE Pacientes.Mutacion_ID in ( 
				SELECT Mutacion_ID 
				FROM Mutacion 
				WHERE  Gen_ID IN (SELECT Gen_ID
								FROM Gen 
								WHERE Gen.Longitud<900
								AND Gen.Longitud>=500)
			AND Mutacion.Tipo= 'Missense/nonsense')
AND Pacientes.DNI in ( SELECT Pacientes.DNI
FROM  Pacientes
WHERE Pacientes.Edad >17
AND Pacientes.Edad <60)
