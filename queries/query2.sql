SELECT Gen.Nombre AS Gene_Symbol, Gen.Longitud AS Longitud_Gen,
	Proteina.Nombre AS Nombre_Proteina
FROM Gen, Mutacion, Proteina, Transcriptoma
WHERE  Mutacion.Tipo = "Missense/nonsense"
	AND Gen.ID = Transcriptoma.Gen_ID
	AND Gen.ID = Mutacion.Gen_ID
    AND Transcriptoma.ID = Proteina.Transcriptoma_ID
    AND Gen.Longitud <= 200
ORDER BY Gen.Longitud ASC;