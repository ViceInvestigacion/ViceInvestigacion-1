create procedure sp_acceso_sel
as
     declare @asistente int;
begin 
 select id_acc,descripcion_acc from accesoBE ;

end 


