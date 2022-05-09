SELECT AVG(Paciente.Edad) AS Edad_Media, Mutacion_Efecto_Fenotipo
FROM Paciente
WHERE Mutacion_Efecto_Fenotipo = "Motor neuropathy, distal";
