
String getPendientesAprobarUrl({required String cedula}) =>
  "/ZV_CDS_HCM_PENDIENTES_CDS/ZV_CDS_HCM_PENDIENTES(codigosap='$cedula')/Set?\$format=json";

const String getTokenManageRequestUrl = 'https://srvqas01.metoronline.com:50101/sap/xi/zhr_int_apr/webhr?sap-client=300';

const String manageRequestUrl = 'https://srvqas01.metoronline.com:50101/sap/xi/zhr_int_apr/webhr?sap-client=300';