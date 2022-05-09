SELECT Paciente.Nombre, Paciente.Ciudad, Efecto.Fenotipo, Efecto.Descripcion AS 'Descripcion enfermedad'
From Paciente, Efecto  
LEFT JOIN Mutacion
ON Mutacion.Efecto_Fenotipo = Efecto.Fenotipo
Where Paciente.Ciudad= "Madrid" AND Paciente.Mutacion_Efecto_Fenotipo=Efecto.Fenotipo ;
