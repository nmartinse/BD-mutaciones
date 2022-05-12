SELECT DISTINCT Proteina.Nombre, Efecto_Fenotipo
FROM Proteina FORCE INDEX (idx_Longitud), Mutacion
WHERE Longitud >= 1700 AND Transcriptoma_ID  IN (SELECT ID FROM Transcriptoma 
	WHERE num_exons > 20 AND Gen_ID IN (SELECT  Gen_ID FROM Mutacion
		WHERE Tipo = "Splicing")) 