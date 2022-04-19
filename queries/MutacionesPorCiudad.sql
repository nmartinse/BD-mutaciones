SELECT Pacientes.Nombre, Pacientes.Ciudad, Efecto.Fenotipo, Efecto.Descripcion AS 'Descripcion enfermedad'
From Pacientes, Efecto  
 LEFT JOIN Mutacion
ON Mutacion.Efecto_Fenotipo = Efecto.Fenotipo
Where Pacientes.Ciudad= "Madrid" AND Pacientes.Mutacion_Efecto_Fenotipo=Efecto.Fenotipo ;
