#############################################################
  #CONSTANTES

  #GENERALES
  USERNAME = "CCARLOS"
  PASSWORD = "123456"
  FECHAHORA = DateTime.now.strftime("%Y-%b-%d_%Hhs")
  FECHAHORASEGUNDO = DateTime.now.strftime("%Y-%b-%d_%H%M%S")
  RUTASCREENSHOT = "C:/CapturasWatir/screenshots/#{FECHAHORA}/"  
  RUTALOGS = "C:/CapturasWatir/Logs/#{FECHAHORA}/"
  #RUTASCRIPTSWATIR = "C:/Users/cargauto/Documents/Files/everis/ProyectoGobierno/Documentación del proyecto/GCABA/GEDO/Automatizaciones/"

  # PARTICULARES DE EE
  MODULOEE = "EE"
  URLMODULOEE = "http://ee-test.gcaba.everis.int/expedientes-web/"
  EERUTALOGS = "C:/CapturasWatir/Logs/EE_#{FECHAHORA}/"
  EEONOMBRELOG = "EE_LOG_#{FECHAHORASEGUNDO}.txt"
  EERUTASCREENSHOT = "C:/CapturasWatir/screenshots/EE_#{FECHAHORA}/"  

  # PARTICULARES DE GEDO
  MODULOGEDO = "GEDO"
  URLMODULOGEDO = "http://gedo-test.gcaba.everis.int/gedo-web/"
  GEDORUTALOGS = "C:/CapturasWatir/Logs/GEDO_#{FECHAHORA}/"
  GEDONOMBRELOG = "GEDO_LOG_#{FECHAHORASEGUNDO}.txt"
  GEDORUTASCREENSHOT = "C:/CapturasWatir/screenshots/GEDO_#{FECHAHORA}/"
  GEDORUTAIMPORTADO = "C:/CapturasWatir/GEDO_11Mar2016114314.png"
  GEDORUTAEMBEBIDO = "C:/Users/cargauto/Downloads/AT/000_Embebido.png"
  VOLVER_BUZON_TAREAS = "VolverAlBuzonTareas.png"
  DESCARGAR_DOCUMENTO = "DescargarDocumento.png"
  #ACRONIMOGEDOLIBRE = "IF"
  #TIPOS DE DOCUMENTO
  #- LIbre  automatizado
  ACRONIMO_GEDO_LIBRE = "IF"
  #- Importado  automatizado
  ACRONIMO_GEDO_IMPORTADO = "IMAUT"
  #- Importado Template  automatizado
  ACRONIMO_GEDO_TEMPLATE = "TMAUT"
  #- Importado Template  automatizado
  ACRONIMO_GEDO_IMP_TEMP = "ITAUT"
  #- Importado Template embebido automatizado
  ACRONIMO_GEDO_IMP_TEMP_EMB = "ITEAU"
  REFERENCIA = "REFERENCIA"
  TEXTOLIBRE = "TEXTO LIBRE"
  TEXTOCAMPOSFC = "111111"
  POSICIONREFERENCIALIBRE = 6
  POSICIONREFERENCIA = 7
  #BOTONES INICIO DE DOCUMENTO
  ARCHIVO_TRABAJO_CONFECCION = "Archivo_Trabajo.png"
  ENVIAR_PRODUCIR_CONFECCION = "EnviarAProducir.png"
  PRODUCIR_YO_MISMO_CONFECCION = "ProducirloYoMismo.png"
  DESTINATARIOS_CONFECCION = "definirDestinatarios.png"
  #BOTONES PRODUCIR DOCUMENTO
  HISTORIAL = "historial_grande.png"
  ENVIAR_REVISAR_PROD = "EnviarARevisar.png"
  ENVIAR_FIRMAR_PROD = "EnviarAFirmar.png"
  FIRMAR_YO_MISMO_PROD = "FirmarYoMismoElDocumento.png"
  TAB_ARCHIVO_TRABAJO = "Archivo_Trabajo.png"
  TAB_ARCHIVO_EMBEBIDO = "Archivo_Embebido.png"
  CARGAR_USUARIOS_FIRMANTES_PROD = "CargarUsuariosFirmantes.png"
  DEFINIR_DESTINATARIOS_PROD = "definirDestinatarios.png"
  #
  FIRMAR_CERTIFICADO = "FirmarConCertificado.png"
  ARCHIVO_TRABAJO_PRODUCCION = "ArchivosDeTrabajo.png"
  CANCELAR = "Cancelar.png"
  #

  #############################################################