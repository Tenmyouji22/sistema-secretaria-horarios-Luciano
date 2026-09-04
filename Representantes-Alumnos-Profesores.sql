CREATE DATABASE IF NOT EXTIST db;

// Tabla representantes
CREATE TABLE IF NOT EXIST representantes(
	id INT PRIMARY KEY,
	cedula VARCHAR(10),
	nombre_completo VARCHAR(70) NOT NULL,
	telefono VARCHAR(20) NOT NULL,
	direccion VARCHAR(70) NOT NULL
);


// Tabla alumnos
CREATE TABLE IF NOT EXIST alumnos(
	ID_alumno INT PRIMARY KEY,
	CI_representante VARCHAR(10)
	cedula_escolar VARCHAR(20) UNIQUE NOT NULL,
	nombre_completo VARCHAR(70) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	grado INT CHECK,
	seccion VARCHAR(1),

	// Restriccion de grado
	CONSTRAINT anio CHECK(grado >= 1 AND grado <= 6),
	
	// Rango de secciones(Desde la A hasta la D)
	CONSTRAINT letra_seccion CHECK(seccion IN ('A', 'B', 'C', 'D')),

	// Clave foranea: Cedula del representante establece relacion 1:N entre representante y alumno
	CONSTRAINT cedula_representante FOREIGN KEY(CI_representante) REFERENCES representantes(cedula)
);

// Tabla profesores
CREATE TABLE IF NOT EXIST profesores(
	ID_profesor INT PRIMARY KEY,
	cedula VARCHAR(10) PRIMARY KEY,
	nombre_completo VARCHAR(70) NOT NULL,
	especialidad VARCHAR(20) NOT NULL,
	telefono VARCHAR(20) NOT NULL,
	salario_base DECIMAL(6,2),

	// Validacion de salario
	CONSTRAINT chk_salario CHECK(salario_base >= 0)
);

// Tabla puente para la relacion N:M entre alumnos y profesores
CREATE TABLE IF NOT EXIST alumno_profesor(
	cedula_alumno VARCHAR(20),
	CI_profesor VARCHAR(10),

	// Referencias
	CONSTRAINT fk_alumno FOREIGN KEY(cedula_alumno) REFERENCES alumnos(cedula_escolar),
	CONSTRAINT fk_profesor FOREIGN KEY(CI_profesor) REFERENCES profesores(cedula)
);
