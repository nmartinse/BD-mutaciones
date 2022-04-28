
ALTER TABLE `mydb`.`Gen` 
ADD INDEX `longitud` (`Longitud` ASC) COMMENT 'indice longitud para gen, query 1' VISIBLE;


ALTER TABLE `mydb`.`Mutacion` 
ADD INDEX `tipo` (`Tipo` ASC) COMMENT 'indice tipo para mutacion, query 1' VISIBLE;


ALTER TABLE `mydb`.`Proteina.` 
ADD INDEX `lengthProt` (`Longitud` ASC) COMMENT 'indice longitud para Proteina, query 5' VISIBLE;
ALTER TABLE `mydb`.`Transcriptoma` 
ADD INDEX `exons` (`exones` ASC) COMMENT 'indice exones para Trascriptoma, query 5' VISIBLE;


ALTER TABLE `mydb`.`Pacientes` 
ADD INDEX `mutCiudad` (`Ciudad` ASC, `Mutacion_Efecto_Fenotipo` ASC) COMMENT 'indice foreing key fenotipo y ciudad para Paciente, query 1'VISIBLE;
;
