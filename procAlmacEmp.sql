use videoClub
go

IF OBJECT_ID ( 'NuevoEmpleado', 'P' ) IS NOT NULL 
	drop proc NuevoEmpleado
go

create proc NuevoEmpleado
  @IdEmpleado	varchar(15),
  @Nombre		varchar(30),
  @Apellido1	varchar(15),
  @Apellido2	varchar(15),
  @Sexo			char(1),
  @FechaNac		date,
  @Telefono		varchar(9),
  @Celular		varchar(9),
  @Direccion	varchar(255),
  @CorreoE		varchar(100),
  @Estado		char(1)
  as
   begin
		if (exists(select * from Empleado where IdEmpleado = @IdEmpleado))
			return 1
		else
			begin
				insert into Empleado (IdEmpleado, Nombre, Apellido1, Apellido2, Sexo, FechaNac,
					Telefono, Celular, Direccion, CorreoE, Estado)
				values (@IdEmpleado, @Nombre, @Apellido1, @Apellido2, @Sexo, @FechaNac, @Telefono, @Celular,
						@Direccion, @CorreoE, @Estado)
				return 0
			end
   end
 go

 IF OBJECT_ID('ModificarEmpleado','P') IS NOT NULL
	drop proc ModificarEmpleado
 go

create proc ModificarEmpleado
  @Id			int,
  @Nombre		varchar(30),
  @Apellido1	varchar(15),
  @Apellido2	varchar(15),
  @Sexo			char(1),
  @FechaNac		date,
  @Telefono		varchar(9),
  @Celular		varchar(9),
  @Direccion	varchar(255),
  @CorreoE		varchar(100),
  @Estado		char(1)

  as
   begin
	  if (not exists (select * from Empleado where Id=@Id))
			return 1
	  else begin
			update Empleado set
				Nombre		= @Nombre,
				Apellido1	= @Apellido1,
				Apellido2	= @Apellido2,
				Sexo		= @Sexo,
				FechaNac	= @FechaNac,
				Telefono	= @Telefono,
				Celular		= @Celular,
				Direccion	= @Direccion,
				CorreoE		= @CorreoE,
				Estado		= @Estado
				where Id = @Id

				return 0
	  end
   end
   go

   if OBJECT_ID('EliminarEmpleado','P') IS NOT NULL
	drop proc EliminarEmpleado
   go

   create proc EliminarEmpleado
	@Id		int
	as
	begin
		if (exists (select * from Empleado where Id=@Id))
			begin
				if (exists(select * from Alquiler where idEmpleado=@Id))
					return 2
				else begin
					delete from Empleado where Id=@Id
					return 1
				end
			end else
					return 0
	end

	go