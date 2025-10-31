/*

a) Devolver por cada reclamo, el detalle de materiales utilizados para
solucionarlo, si un reclamo no uso materiales, listarlo también.

*/

SELECT Reclamo.Nro_reclamo, Material.Cod_material, Material.Descripcion, Registro.cantidad
FROM Reclamo
LEFT JOIN Registro ON Reclamo.Nro_reclamo = Registro.Nro_reclamo
LEFT JOIN Material ON Registro.Cod_material = Material.Cod_material
ORDER BY Reclamo.Nro_reclamo;

------------------------------------------------------------------

/*

b) Devolver los usuarios que tienen más de un reclamo.

*/

SELECT Usuario.Id_usuario, Usuario.nombre, COUNT(Reclamo.Nro_reclamo) cantidad_reclamos
FROM Usuario
INNER JOIN Reclamo ON Usuario.Id_usuario = Reclamo.Id_usuario
GROUP BY Usuario.Id_usuario, Usuario.nombre
HAVING COUNT(Reclamo.Nro_reclamo) > 1
ORDER BY cantidad_reclamos DESC;

------------------------------------------------------------------

/*

Listado de reclamos que fueron asignados a más de un empleado de
mantenimiento.
*/

SELECT Reclamo.Nro_reclamo, COUNT(Mantenimiento.Id_usuario) cantidad_empleados
FROM Reclamo
INNER JOIN Mantenimiento ON Reclamo.Nro_reclamo = Mantenimiento.Nro_reclamo
GROUP BY Reclamo.Nro_reclamo
HAVING COUNT(Mantenimiento.Id_usuario) > 1
ORDER BY Reclamo.Nro_reclamo;
