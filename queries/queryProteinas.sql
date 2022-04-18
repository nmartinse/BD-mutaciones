SELECT DISTINCT Proteina.Nombre, Efecto_Fenotipo
FROM Proteina, Mutacion
WHERE Longitud >= 700 AND Transcriptoma_ID IN (SELECT ID FROM Transcriptoma
	WHERE num_exons > 5 AND Gen_ID IN (SELECT Gen_ID FROM Mutacion
		WHERE Tipo = "Splicing"))