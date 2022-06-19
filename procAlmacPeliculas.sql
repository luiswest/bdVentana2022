use VideoClub
go


if OBJECT_ID('NuevaPelicula','P') IS NOT NULL
	drop procedure NuevaPelicula
go

create proc NuevaPelicula
  @Genero		varchar(50),
  @Nombre		varchar(50),
  @Valor		smallmoney,
  @Rating		varchar(5)
  as
   begin
		insert into Pelicula (Genero, Nombre, Valor, Rating)
				values (@Genero, @Nombre, @Valor, @Rating)
   end
 go

if OBJECT_ID('ModificarPelicula','P') IS NOT NULL
	drop procedure ModificarPelicula
go

create proc ModificarPelicula
  @Id			int,
  @Genero		varchar(10),
  @Nombre		varchar(50),
  @Valor		smallmoney,
  @Rating		varchar(5)
  as
   begin
	  if (not exists (select * from Pelicula where Id=@Id))
		return 1 
	  else begin
			update Pelicula set
				  Genero = @Genero,
				  Nombre = @Nombre,
				  Valor = @Valor,
				  Rating  = @Rating
			where Id = @Id
			return 0
	  end
   end
   go

   if OBJECT_ID('EliminarPelicula','P') IS NOT NULL
	drop proc EliminarPelicula
   go

   create proc EliminarPelicula
	@Id		int
	as
	begin
		if (exists (select * from Pelicula where Id=@Id))
			begin
				if (exists(select * from detAlquiler where IdPelicula = @Id))
					return 2
				else begin
					delete from Pelicula where Id=@Id
					return 0
				end
			end else
					return 1
	end
	go