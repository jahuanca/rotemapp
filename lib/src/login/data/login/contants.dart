String loginGetUrl({
  required String username,
  required String password,
}) =>
    "/ZV_CDS_HCM_USUARIOS_CDS/ZV_CDS_HCM_USUARIOS(iusuario='$username',iclave='$password')/Set?\$format=json";
