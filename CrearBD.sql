use master
go
-- Crea la base de datos si existía la elimina primero
if (DB_ID('bodega') is NOT NULL)
    drop database videoClub
create database videoClub
go

use videoClub
go
-- Crear las tablas

create table Empleado (
	Id			int	identity(1000, 1) NOT NULL,
    IdEmpleado	varchar (15) NOT NULL,
    Nombre      varchar (30) NOT NULL,
    Apellido1   varchar (15) NOT NULL,
    Apellido2   varchar (15) NOT NULL,
    Sexo		char(1)	check(Sexo in ('M','F')) NOT NULL,
    FechaNac    date         NOT NULL,	
    Telefono    varchar (9)  NULL,
    Celular 	varchar (9)  NOT NULL,
  	Direccion	varchar(255),
	CorreoE   	varchar (100) NOT NULL,
  	Estado		char(1)	check(Estado in ('A','I')) NOT NULL,
	primary key clustered (Id ASC)
);

go

create table Pelicula (
    Id      int NOT NULL,
  	Genero	varchar(10) NOT NULL,
  	Nombre	varchar(50) NOT NULL,
  	Valor	smallmoney NOT NULL,
  	Rating	varchar(5) NOT NULL,
    primary key clustered (Id ASC)
);

go

create table Socio (
	Carnet		char(6) NOT NULL,	
  	IdSocio		varchar (15) NOT NULL,
  	Nombre		varchar(40) NOT NULL,
  	Apellido1	varchar(15) NOT NULL,
  	Apellido2	varchar(15) NOT NULL,
  	Sexo		char(1)	check(Sexo in ('M','F')) NOT NULL,
  	FechaNac	date NOT NULL,
  	Telefono	varchar(9),
  	Celular		varchar(9) NOT NULL,
  	Direccion	varchar(255),
    CorreoE   	varchar (100) NOT NULL,
	Estado		char(1)	check(Estado in ('A','I','S')) NOT NULL,
    primary key clustered (Carnet ASC)
);

go

create table Alquiler (
		Id		 		int	identity(1, 1) NOT NULL,
		Fecha       	date default getdate(),
		Dias			int NOT NULL,
		TipoMovimiento 	char(1) check(tipoMovimiento in ('E','S')) NOT NULL,
		IdEmpleado	 	int NOT NULL,
		CarnetSocio	 	char(6) NOT NULL,
		primary key clustered (Id ASC),
		constraint fk_AlqEmpleado foreign key (IdEmpleado)
		references Empleado(Id),
		constraint fk_AlqSocio foreign key (CarnetSocio)
		references Socio(Carnet)
		)
	go

create table detAlquiler (
		IdDetalle 	int	identity(1, 1) NOT NULL,
		IdAlquiler	int	NOT NULL,
		IdPelicula	int NOT NULL,
		precio 		smallmoney NOT NULL,
		Estado 		char(1) check(Estado in ('A', 'D')) NOT NULL,
		primary key clustered (IdDetalle ASC),
		constraint fk_Alquiler foreign key (IdAlquiler)
		references Alquiler(Id),
		constraint fk_DetPelicula foreign key (IdPelicula)
		references Pelicula(Id)
)
go
create table usuario (
		codigoUsr 		int	identity(1, 1) NOT NULL,
		IdEmp			int NOT NULL,
		rol				char(1)	check(rol in ('A','E')) NOT NULL,
		passw			varchar(255),
		primary key clustered (CodigoUsr ASC),
		constraint fk_UsuarioEmp foreign key (IdEmp)
		references Empleado(Id),
)
go