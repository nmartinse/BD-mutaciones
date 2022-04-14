SELECT  Mutacion.Tipo, Gen.Nombre, Proteina.Nombre, Mutacion.Efecto_Fenotipo
FROM Mutacion,Gen,Proteina
WHERE Gen.ID = 102545
AND Proteina.Gen_ID= Gen.ID
AND Mutacion.Tipo= "Splicing";