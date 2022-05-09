SELECT DISTINCT
Paciente.Apellidos AS 'Paciente',Paciente.Edad, Paciente.Mutacion_Efecto_Fenotipo AS 'Enfermedad', Paciente.Mutacion_Gen_ID AS ' ID Gen afectado'

FROM  Paciente
WHERE Paciente.Mutacion_ID in ( 
  SELECT Mutacion_ID 
  FROM Mutacion 
  WHERE  Gen_ID IN (SELECT Gen_ID
                    FROM Gen 
                    WHERE Gen.Longitud<900
                    AND Gen.Longitud>=500)
  AND Mutacion.Tipo= 'Missense/nonsense')
AND Paciente.DNI in ( SELECT Paciente.DNI
                       FROM  Paciente
                       WHERE Paciente.Edad >17
                       AND Paciente.Edad <60)
