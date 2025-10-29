-- 1. Tabla Usuario 
CREATE TABLE Usuario (
    Id_usuario INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    CONSTRAINT PK_Usuario PRIMARY KEY (Id_usuario)
);

------------------------------------------------------------------

-- 2. Tabla Reclamo 
CREATE TABLE Reclamo (
    Nro_reclamo INT NOT NULL AUTO_INCREMENT,
    Id_usuario INT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Fecha_resolucion DATE NULL,
    CONSTRAINT PK_Reclamo PRIMARY KEY (Nro_reclamo),
    CONSTRAINT FK_Reclamo_Usuario FOREIGN KEY (Id_usuario) REFERENCES Usuario(Id_usuario) ON DELETE CASCADE
);

------------------------------------------------------------------

-- 3. Tabla Material 
CREATE TABLE Material (
    Cod_material INT NOT NULL AUTO_INCREMENT,
    Descripcion VARCHAR(255) NOT NULL,
    CONSTRAINT PK_Material PRIMARY KEY (Cod_material)
);

------------------------------------------------------------------

-- 4. Tabla Tel 
CREATE TABLE Tel (
    Id_usuario INT NOT NULL,
    Tel VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Tel PRIMARY KEY (Id_usuario, Tel),
    CONSTRAINT FK_Tel_Usuario FOREIGN KEY (Id_usuario) REFERENCES Usuario(Id_usuario) ON DELETE CASCADE
   
);

------------------------------------------------------------------

-- 5. Tabla Empresa 
CREATE TABLE Empresa (
    Id_usuario INT NOT NULL,
    Cuit VARCHAR(20) NOT NULL UNIQUE,
    Kw INT NULL CHECK (Kw >= 0 AND Kw <= 50000),
    CONSTRAINT PK_Empresa PRIMARY KEY (Id_usuario),
    CONSTRAINT FK_Empresa_Usuario FOREIGN KEY (Id_usuario) REFERENCES Usuario(Id_usuario) ON DELETE CASCADE
);

------------------------------------------------------------------

-- 6. Tabla Persona 
CREATE TABLE Persona (
    Id_usuario INT NOT NULL,
    Dni INT NOT NULL UNIQUE CHECK (Dni > 0 AND Dni < 1000000000),
    CONSTRAINT PK_Persona PRIMARY KEY (Id_usuario),
    CONSTRAINT FK_Persona_Usuario FOREIGN KEY (Id_usuario) REFERENCES Usuario(Id_usuario) ON DELETE CASCADE
);

------------------------------------------------------------------

-- 7. Tabla Empleado 
CREATE TABLE Empleado (
    Id_usuario INT NOT NULL,
    sueldo DECIMAL(10, 2) NOT NULL,
    Dni INT NOT NULL UNIQUE CHECK (Dni > 0 AND Dni < 1000000000),
    Apellido VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Empleado PRIMARY KEY (Id_usuario),
    CONSTRAINT FK_Empleado_Usuario FOREIGN KEY (Id_usuario) REFERENCES Usuario(Id_usuario) ON DELETE CASCADE
);

------------------------------------------------------------------

-- 8. Tabla Motivo 
CREATE TABLE Motivo (
    Cod INT NOT NULL,
    Nro_reclamo INT NOT NULL,
    Descripcion VARCHAR(255) NOT NULL,
    CONSTRAINT PK_Motivo PRIMARY KEY (Cod, Nro_reclamo),
    CONSTRAINT FK_Motivo_Reclamo FOREIGN KEY (Nro_reclamo) REFERENCES Reclamo(Nro_reclamo) ON DELETE CASCADE
);

------------------------------------------------------------------

-- 9. Tabla Mantenimiento
CREATE TABLE Mantenimiento (
    Nro_reclamo INT NOT NULL,
    Id_usuario INT NOT NULL,
    CONSTRAINT PK_Mantenimiento PRIMARY KEY (Nro_reclamo, Id_usuario),
    CONSTRAINT FK_Mantenimiento_Reclamo FOREIGN KEY (Nro_reclamo) REFERENCES Reclamo(Nro_reclamo) ON DELETE CASCADE,
    CONSTRAINT FK_Mantenimiento_Usuario FOREIGN KEY (Id_usuario) REFERENCES Usuario(Id_usuario) ON DELETE CASCADE
);

------------------------------------------------------------------

-- 10. Tabla Rellamado
CREATE TABLE Rellamado (
    Nro_reclamo INT NOT NULL,
    Tel VARCHAR(20) NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    CONSTRAINT PK_Rellamado PRIMARY KEY (Nro_reclamo),
    CONSTRAINT FK_Rellamado_Reclamo FOREIGN KEY (Nro_reclamo) REFERENCES Reclamo(Nro_reclamo) ON DELETE CASCADE
);

------------------------------------------------------------------

-- 11. Tabla Registro 
CREATE TABLE Registro (
    Cod_material INT NOT NULL,
    Nro_reclamo INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT PK_Registro PRIMARY KEY (Cod_material, Nro_reclamo),
    CONSTRAINT FK_Registro_Material FOREIGN KEY (Cod_material) REFERENCES Material(Cod_material),
    CONSTRAINT FK_Registro_Reclamo FOREIGN KEY (Nro_reclamo) REFERENCES Reclamo(Nro_reclamo) ON DELETE CASCADE
);

------------------------------------------------------------------
-- 12. Tabla de Auditoría para Reclamos Eliminados
------------------------------------------------------------------
CREATE TABLE Reclamo_Auditoria_Eliminacion (
    Id_auditoria INT NOT NULL AUTO_INCREMENT,
    Nro_reclamo_eliminado INT NOT NULL,
    Fecha_eliminacion DATETIME NOT NULL,
    Usuario_eliminacion VARCHAR(255) NOT NULL,
    PRIMARY KEY (Id_auditoria)
);

------------------------------------------------------------------
-- Trigger para auditar eliminaciones de Reclamos
------------------------------------------------------------------
DELIMITER //

CREATE TRIGGER trg_after_delete_reclamo
AFTER DELETE ON Reclamo
FOR EACH ROW
BEGIN
    INSERT INTO Reclamo_Auditoria_Eliminacion (Nro_reclamo_eliminado, Fecha_eliminacion, Usuario_eliminacion)
    VALUES (OLD.Nro_reclamo, NOW(), USER());
END;
//

DELIMITER ;