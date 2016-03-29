  # Alta de documento GEDO
  #############################################################
  require 'watir-webdriver'
  require 'logger'
  #Levantar las constantes declaradas
  require '../0000_Constantes.rb'
  # Genera los dorectorios de logs
  require '../0000_Directorios_GEDO.rb'
  require './login.rb'
  # Clases de documentos
  require './documentoLibre.rb'
  require './documentoTemplate.rb'
  require './documentoImportado.rb'
  require './documentoImportadoTemplate.rb'

  #login = Login.new(URLMODULOGEDO, USERNAME, PASSWORD)
  login = Login.new()
  browser = login.ingresar()

  ## ImportadoTemplate con Embebido
  documentoImportadoTemplateEmbebido = DocumentoImportadoTemplate.new(browser, ACRONIMO_GEDO_IMP_TEMP_EMB)
  documentoImportadoTemplateEmbebido.iniciarProduccionDocumento()
  documentoImportadoTemplateEmbebido.producir_yo_mismo()
  documentoImportadoTemplateEmbebido.producirDocumentoConEmbebidos(REFERENCIA) # Método específico si tiene embebidos
  documentoImportadoTemplateEmbebido.firmar_yo_mismo_prod()
  documentoImportadoTemplateEmbebido.firmaDeDocumentoConEmbebidosConCertificado() # Método específico si tiene embebidos
  documentoImportadoTemplateEmbebido.copiarCodigoSadeGenerado()
  documentoImportadoTemplateEmbebido.volverBuzonDeTareas()
  
  ## ImportadoTemplate
  documentoImportadoTemplate = DocumentoImportadoTemplate.new(browser, ACRONIMO_GEDO_IMP_TEMP)
  documentoImportadoTemplate.iniciarProduccionDocumento()
  documentoImportadoTemplate.producir_yo_mismo()
  documentoImportadoTemplate.producirDocumento(REFERENCIA)
  documentoImportadoTemplate.firmar_yo_mismo_prod()
  documentoImportadoTemplate.firmaDeDocumentoConCertificado()
  documentoImportadoTemplate.copiarCodigoSadeGenerado()
  documentoImportadoTemplate.volverBuzonDeTareas()

  ## Importado
  documentoImportado = DocumentoImportado.new(browser, ACRONIMO_GEDO_IMPORTADO)
  documentoImportado.iniciarProduccionDocumento()
  documentoImportado.producir_yo_mismo()
  documentoImportado.producirDocumento(REFERENCIA)
  documentoImportado.firmar_yo_mismo_prod()
  documentoImportado.firmaDeDocumentoConCertificado()
  documentoImportado.copiarCodigoSadeGenerado()
  documentoImportado.volverBuzonDeTareas()

  ## Template
  documentoTemplate = DocumentoTemplate.new(browser, ACRONIMO_GEDO_TEMPLATE)
  documentoTemplate.iniciarProduccionDocumento()
  documentoTemplate.producir_yo_mismo()
  documentoTemplate.producirDocumento(REFERENCIA)
  documentoTemplate.firmar_yo_mismo_prod()
  documentoTemplate.firmaDeDocumentoConCertificado()
  documentoTemplate.copiarCodigoSadeGenerado()
  documentoTemplate.volverBuzonDeTareas()

  ## Libre
  documentoLibre = DocumentoLibre.new(browser, ACRONIMO_GEDO_LIBRE)
  documentoLibre.iniciarProduccionDocumento()
  documentoLibre.producir_yo_mismo()
  documentoLibre.producirDocumento(REFERENCIA, TEXTOLIBRE)
  documentoLibre.firmar_yo_mismo_prod()
  documentoLibre.firmaDeDocumentoConCertificado()
  documentoLibre.copiarCodigoSadeGenerado()
  documentoLibre.volverBuzonDeTareas()
  #############################################################