SELECT AVG(Pacientes.Edad) AS Edad_Media, Mutacion_Efecto_Fenotipo
FROM Pacientes
WHERE Mutacion_Efecto_Fenotipo = "Motor neuropathy, distal";