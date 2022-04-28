SELECT DISTINCT Proteina.Nombre, Efecto_Fenotipo
FROM Proteina, Mutacion
WHERE Longitud >= 700 AND Transcriptoma_ID IN (SELECT ID FROM Transcriptoma FORCE INDEX (exones)
	WHERE num_exons > 5 AND Gen_ID IN (SELECT Gen_ID FROM Mutacion FORCE INDEX (tipo)
		WHERE Tipo = "Splicing"))
