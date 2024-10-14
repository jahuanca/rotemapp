
String getPendientesAprobarUrl({required String cedula}) =>
  "/ZV_CDS_HCM_PENDIENTES_CDS/ZV_CDS_HCM_PENDIENTES(codigosap='$cedula')/Set?\$format=json";