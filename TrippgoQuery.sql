USE MASTER
go

Drop database if exists trippgo
go
Create database trippgo
go

use trippgo
go

CREATE TABLE usuarios(
id_user int primary key identity(1,1),
Nombre_user varchar (20),
Contraseña Varchar(20),
estado varchar(5) DEFAULT 'desactivo'
);


CREATE TABLE Regiones(
Id_region int primary key identity(1,1),
Nombre_region varchar(30),
codigo_postal Char(10) unique
);

CREATE TABLE personas(
Id_personas int primary key identity  (1,1),
Nombre varchar(20),
Apellidos Varchar(20),
Correo_Electronico Varchar(50) Unique,
id_region int,
id_user int
);

ALTER TABLE personas
ADD CONSTRAINT fk_personas_usuarios
FOREIGN KEY (id_user)
REFERENCES usuarios(id_user)
;

ALTER TABLE personas
ADD CONSTRAINT fk_personas_Regiones
FOREIGN KEY (id_region)
REFERENCES Regiones(Id_region)
;

CREATE TABLE tipos_locales(
id_tipo_local int primary key identity(1,1),
Tipo_local varchar (20), --default Hotel, Restaurante, Servicio turistico--
Identificador int --default 1,2,3--
);

CREATE TABLE tipo_de_lugares(
id_tipo_de_lugar int primary key identity(1,1),
Nombre_tipo_Lg Varchar (30),
Descripcion Varchar(30)
);

CREATE TABLE tblocales(
id_local int primary key identity(1,1),
Nombre_local varchar(20),
descripcion varchar(100),
id_tipo_local int,
id_tipo_de_lugar int,
Ubicacion geography,
id_user int,
horarios datetime --arreglar para que se puedan poner dias y horarios--
);

ALTER TABLE tblocales
ADD CONSTRAINT fk_ptblocales_tipos_locales
FOREIGN KEY (id_tipo_local)
REFERENCES tipos_locales(id_tipo_local)
;

ALTER TABLE tblocales
ADD CONSTRAINT fk_ptblocales_tipo_de_lugares
FOREIGN KEY (id_tipo_de_lugar)
REFERENCES tipo_de_lugares(id_tipo_de_lugar)
;

ALTER TABLE tblocales
ADD CONSTRAINT fk_tblocales_usuarios
FOREIGN KEY (id_user)
REFERENCES usuarios(id_user)
;

CREATE TABLE tbfotosLocales(
id_foto_local int primary key identity(1,1),
foto image,
id_local int
);

ALTER TABLE tbfotosLocales
ADD CONSTRAINT fk_tbfotosLocales_tblocales
FOREIGN KEY (id_local)
REFERENCES tblocales(id_local)
;

CREATE TABLE servicios_locales(
id_servicios_locales int primary key identity (1,1),
Nombre_servicio varchar(30),
Descripcion varchar(60),
precio money,
id_local int
);

ALTER TABLE servicios_locales
ADD CONSTRAINT fk_servicios_locales_tblocales
FOREIGN KEY (id_local)
REFERENCES tblocales(id_local)
;

CREATE TABLE tbfotosServicio(
id_foto int primary key identity(1,1),
foto image,
id_servicios_locales int
);

ALTER TABLE tbfotosServicio
ADD CONSTRAINT fk_tbfotosServicio_locales_tblocales
FOREIGN KEY (id_servicios_locales)
REFERENCES servicios_locales(id_servicios_locales)
;

CREATE TABLE locales_favoritos(
id_local_fav int primary key identity(1,1),
id_local int,
id_user int
);

ALTER TABLE locales_favoritos
ADD CONSTRAINT fk_locales_favoritos_tblocales
FOREIGN KEY (id_local)
REFERENCES tblocales(id_local)
;

ALTER TABLE locales_favoritos
ADD CONSTRAINT fk_locales_favoritos_usuarios
FOREIGN KEY (id_user)
REFERENCES usuarios(id_user)
;

CREATE TABLE tbmensajes(
id_mensaje int primary key identity (1,1),
remitente_id int,
destinatario_id int, 
contenido varchar(30),
fecha_envio date,
leido BIT
);

ALTER TABLE tbmensajes
ADD CONSTRAINT fk_tbmensajes_usuarios_emisor
FOREIGN KEY (remitente_id)
REFERENCES usuarios(id_user)
;

ALTER TABLE tbmensajes
ADD CONSTRAINT fk_tbmensajes_usuarios_Destinatario
FOREIGN KEY (destinatario_id)
REFERENCES usuarios(id_user)
;

CREATE TABLE Clasificacion_Preferencias(
Id_Clasificacion_PF int primary key identity (1,1),
Nombre varchar(20),
Categoria_PR Varchar
);


CREATE TABLE preferencias(
id_preferencias int primary key identity (1,1),
Id_Clasificacion_PF int,
Descripcion varchar(20),
id_local int
);

ALTER TABLE preferencias
ADD CONSTRAINT fk_preferencias_Clasificacion_Preferencias
FOREIGN KEY (Id_Clasificacion_PF)
REFERENCES Clasificacion_Preferencias(Id_Clasificacion_PF)
;

ALTER TABLE preferencias
ADD CONSTRAINT fk_preferencias_tblocales
FOREIGN KEY (id_local)
REFERENCES tblocales(id_local)
;
CREATE TABLE tbtipos_de_Ubicación(
id_tipo_ubicacion int primary key identity(1,1),
tipo_ubicacion varchar(30)
);

CREATE TABLE tbUbicaciones_seguridad(
id_ubicacion_Seg int primary key identity(1,1),
Nombre varchar (20),
Ubicacion Geography,
telefono VARCHAR(20) CHECK (telefono LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9]'),
Horarios datetime,
Imagen image,
id_tipo_ubicacion int,
id_region int,
id_user int
);

ALTER TABLE tbUbicaciones_seguridad
ADD CONSTRAINT fk_tbUbicaciones_seguridad_Regiones
FOREIGN KEY (id_tipo_ubicacion)
REFERENCES tbtipos_de_Ubicación(id_tipo_ubicacion)
;

ALTER TABLE tbUbicaciones_seguridad
ADD CONSTRAINT fk_tbUbicaciones_seguridad_Regiones2
FOREIGN KEY (id_region)
REFERENCES Regiones(id_region)
;


ALTER TABLE tbUbicaciones_seguridad
ADD CONSTRAINT fk_tbUbicaciones_seguridad_usuarios
FOREIGN KEY (id_user)
REFERENCES usuarios(id_user)
;

CREATE TABLE tb_tipo_eventos(
id_tipo_evento int primary key identity(1,1),
tipo_evento varchar(30)
);

CREATE TABLE tb_eventos_regionales(
id_evento int primary key identity(1,1),
Nombre varchar(20),
Ubicacion geography,
Fecha_inicio Datetime,
Fecha_final Datetime,
id_tipo_evento int,
id_region int,
id_user int
);

ALTER TABLE tb_eventos_regionales
ADD CONSTRAINT fk_tb_eventos_regionales_Regiones
FOREIGN KEY (id_tipo_evento)
REFERENCES tb_tipo_eventos(id_tipo_evento)
;

ALTER TABLE tb_eventos_regionales
ADD CONSTRAINT fk_tb_eventos_regionales_seguridad_Regiones
FOREIGN KEY (id_region)
REFERENCES Regiones(id_region)
;


ALTER TABLE tb_eventos_regionales
ADD CONSTRAINT fk_tb_eventos_regionales_seguridad_usuarios
FOREIGN KEY (id_user)
REFERENCES usuarios(id_user)
;

CREATE TABLE tbComentarios(
id_comentario int primary key identity(1,1),
comentarios varchar(60),
calificacion int,
id_user int,
id_local int
);
 
ALTER TABLE tbComentarios 
ADD CONSTRAINT fk_tbComentarios_tbusuarios
FOREIGN KEY (id_user)
REFERENCES usuarios(id_user)

ALTER TABLE tbComentarios
ADD CONSTRAINT fk_tbComentarios_tblocales
FOREIGN KEY (id_local)
REFERENCES tblocales(id_local)


CREATE TABLE Tipo_Denuncias(
id_tipo_denuncia int primary key identity(1,1),
nombre varchar(20),
categoria varchar(20)
);

CREATE TABLE Denuncias(
id_Denuncia int primary key identity(1,1),
cantidad_denuncia int,
id_tipo_denuncia int,
otro varchar(50),
id_user INT
);

ALTER TABLE Denuncias
ADD CONSTRAINT fk_denuncias_Tipo_Denuncias
FOREIGN KEY (id_tipo_denuncia)
REFERENCES Tipo_Denuncias(id_tipo_denuncia)

ALTER TABLE Denuncias 
ADD CONSTRAINT fk_DENUNCIAS_tbusuarios
FOREIGN KEY (id_user)
REFERENCES usuarios(id_user)