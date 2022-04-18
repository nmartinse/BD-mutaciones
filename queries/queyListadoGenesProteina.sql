SELECT Gen.Nombre AS Gene_Symbol, Gen.ID_ncbi AS NCBI,
	Proteina.Nombre AS Proteina_Nombre, Proteina.Descripcion
FROM Gen, Proteina
JOIN Transcriptoma
ON Transcriptoma.ID = Proteina.Transcriptoma_ID
WHERE Gen.ID = Transcriptoma.Gen_ID;