use VideoClub
go

IF OBJECT_ID ( 'NuevoSocio', 'P' ) IS NOT NULL 
	drop proc NuevoSocio
go

create proc NuevoSocio
  @Carnet		char(6),
  @Nombre		varchar(40),
  @Apellido1	varchar(15),
  @Apellido2	varchar(15),
  @Sexo			char(1),
  @FechaNac		date,
  @Telefono		int,
  @Celular		int,
  @Direccion	varchar(255),
  @CorreoE		varchar(100),
  @Estado		char(1)
  as
   begin
		if (exists(select * from Socio where Carnet = @Carnet))
			return 1
		else
			begin
				insert into Socio (Carnet, Nombre, Apellido1, Apellido2, Sexo, FechaNac,
					Telefono, Celular, Direccion, CorreoE, Estado)
				values (@Carnet, @Nombre, @Apellido1, @Apellido2, @Sexo, @FechaNac, @Telefono, @Celular,
						@Direccion, @CorreoE, @Estado)
				return 0
			end
   end
 go

IF OBJECT_ID ( 'ModificarSocio', 'P' ) IS NOT NULL 
	drop proc ModificarSocio
go

create proc ModificarSocio
  @Carnet		varchar(6),
  @Nombre		varchar(40),
  @Apellido1	varchar(15),
  @Apellido2	varchar(15),
  @Sexo			char(1),
  @FechaNac		date,
  @Telefono		int,
  @Celular		int,
  @Direccion	varchar(255),
  @CorreoE		varchar(100),
  @Estado		char(1)

  as
   begin
	  if (not exists (select * from Socio where Carnet=@Carnet))
			return 0
	  else begin
			update Socio set
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
				where Carnet = @Carnet

				return 1
	  end
   end
   go

   IF OBJECT_ID ( 'EliminarSocio', 'P' ) IS NOT NULL 
	 drop proc EliminarSocio
   go

   create proc EliminarSocio
	@Carnet		varchar(6)
	as
	begin
		if (exists (select * from Socio where Carnet=@Carnet))
			begin
				if (exists(select * from Alquiler where CarnetSocio = @Carnet))
					return 2
				else
					begin
					  delete from Socio where Carnet=@Carnet
					  return 1
					end
			end else
					return 0
	end

	go