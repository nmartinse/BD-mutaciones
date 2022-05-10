SELECT CONCAT ('<BD>',
group_concat('<Paciente DNI= "' , Paciente.DNI, '" Clinica="',Paciente.Clinica,
'" Nombre="',Paciente.Nombre,'" Apellidos="',Paciente.Apellidos,'" Edad="',Paciente.Edad,
'" Pais="',Paciente.Pais,'" Ciudad="',Paciente.Ciudad, '">',
	(		SELECT CONCAT (
				 group_concat('<Mutacion ID= "' , Mutacion.ID, '" Codon_afectado="',Mutacion.Codon_afectado,
				'" Tipo="',Mutacion.Tipo,'"> ',(
                SELECT CONCAT ( 
					group_concat('<Efecto Fenotipo= "' , Efecto.Fenotipo,'">',
																											
								'','' separator''), 
						'</Efecto>')  FROM Efecto
					GROUP BY Efecto.Fenotipo
					HAVING Efecto.Fenotipo= Mutacion.Efecto_Fenotipo
                ),
                (SELECT CONCAT (
group_concat('<Gen ID= "' , Gen.ID,'" Longitud= "' , Gen.Longitud,'" Nombre= "' , Gen.Nombre,'" Posicion= "' , Gen.Posicion,'" Funcion= "' , Gen.Funcion,'">',
	
																							(SELECT CONCAT (
																							 group_concat('<Transcriptoma ID= "' , Transcriptoma.ID, '" Longitud="',Transcriptoma.Longitud, '" num_exons="',Transcriptoma.num_exons,'">',
																												(SELECT CONCAT ( 
																												 group_concat('<Proteina ID= "' , Proteina.ID,'" Nombre="',Proteina.Nombre, '" Longitud="',Proteina.Longitud,'">',
																											
																													'','' separator''), 
																													'</Proteina>')  FROM Proteina
																													GROUP BY Proteina.Transcriptoma_ID
																														HAVING Proteina.Transcriptoma_ID=Transcriptoma.ID
																													
																													
																												),
																								'' separator''), 
																								'</Transcriptoma>') FROM Transcriptoma 
																								
																	GROUP BY Transcriptoma.Gen_ID
															HAVING Transcriptoma.Gen_ID=Mutacion.Gen_ID
																),
                                                                
                                               '','' separator''), 	
										'</Gen>')                  
												From Gen
												group by Gen.ID
												Having Gen.ID= Mutacion.Gen_ID


                                            

				

		
),
                '' separator''), 
				'</Mutacion></Paciente> ') 
                FROM Mutacion 
                GROUP BY Mutacion.ID
                HAVING Mutacion.ID=Paciente.Mutacion_ID




)
,'' separator''), 
'</BD>') as xmldoc FROM Paciente ;



