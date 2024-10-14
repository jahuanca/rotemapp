
String getSolicitudesUrl(
  {
    required String cedula, 
    required String fechaInicio,
    required String fechaFin
  }) =>
  "/ZV_CDS_HCM_HIS_SOLICITUDES_CDS/ZV_CDS_HCM_HIS_SOLICITUDES(codigo='$cedula',fechaini=datetime'$fechaInicio',fechafin=datetime'$fechaFin')/Set?&\$format=json";

String getUserAmountsUrl({
  required String cedula
}) => "/ZW_HCM_VISUALIZARSOLICITUD_SRV/T_VISUALIZARIMPORTESET?\$filter=Pernr eq '$cedula'&\$format=json";

const String getTokenCreateRequestUrl = 'https://srvqas01.metoronline.com:50101/sap/xi/zhr_int_sol/webhr?sap-client=300'; 

const String createUserRequestUrl = 'https://srvqas01.metoronline.com:50101/sap/xi/zhr_int_sol/webhr?sap-client=300';