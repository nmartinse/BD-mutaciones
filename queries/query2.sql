SELECT Gen.Nombre, Proteina.Nombre
FROM Gen, Mutacion, Proteina
WHERE  Mutacion.Tipo = "Missense/nonsense"
	AND Gen.ID = Proteina.Gen_ID
	AND Gen.ID = Mutacion.Gen_ID
    AND longitud <= 500;