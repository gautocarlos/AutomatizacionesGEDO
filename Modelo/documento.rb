# Clase que se utiliza para dar de alta un nuevo documento GEDO del tipo libre#
  require 'watir-webdriver'
  require 'logger'
  require '../constantes.rb'
  class Documento
    attr_accessor
      :browser
      :log
      :acronimo
      :referencia
      #:texto_libre
      :boton_archivo_trabajo_confec
      :boton_enviar_producir
      :boton_producir_yo_mismo
      :boton_enviar_prod_confec
      :boton_destinatarios_confec
      :boton_archivos_trabajo_prod
      #
      :boton_firmar_yo_mismo_prod
      #
      :boton_firmar_certificado
      :boton_volver_buzon_tareas
      :boton_descargar_documento
      #
      :tab_archivos_embebidos
      :ffcc
      :rutaImportado
      :rutaEmbebido
      :datosGEDOParseo
    # constructor
    #def initialize(browser, acronimo)
    def initialize(browser)
      #@browser = browser
      self.setBrowser(browser)
      #@acronimo = acronimo
      @log = Logger.new('C:\CapturasWatir\Logs\Logs.txt') #DEBUG
      #@log = Logger.new("#{GEDORUTALOGS}#{GEDONOMBRELOG}")
      #self.
      parseJSON()
    end
    def parseJSONGenerico(datosGEDOParseo)
      #archivoDatosGEDO = open("../JSON/documentoTemplate.json")
      #datosGEDO = archivoDatosGEDO.read
      #datosGEDOParseo = JSON.parse(datosGEDO)
      self.setAcronimo(datosGEDOParseo["documentoGEDO"]["acronimo"])
      self.setReferencia(datosGEDOParseo["documentoGEDO"]["referencia"])
      if (datosGEDOParseo["documentoGEDO"]["rutaEmbebido"] != nil)
        self.setRutaEmbebido(datosGEDOParseo["documentoGEDO"]["rutaEmbebido"])
      end
      #self.setDatosGEDOParseo(datosGEDOParseo)
      #return datosGEDOParseo
      #self.setFFCC(datosGEDOParseo["documentoGEDO"]["ffcc"])
    end
    # 
    def parseJSONFFCC(datosGEDOParseo)
      self.setFFCC(datosGEDOParseo["documentoGEDO"]["ffcc"])
    end
    # 
    def parseJSONIMPORTADO(datosGEDOParseo)
      self.setRutaImportado(datosGEDOParseo["documentoGEDO"]["rutaImportado"])
    end
    def parseJSONEMBEBIDO(datosGEDOParseo)
      self.setRutaEmbebido(datosGEDOParseo["documentoGEDO"]["rutaEmbebido"])
    end

    # Cada tipo de documento deberá implementar su manera de parsear
    #def parseJSON
      #archivoDatosGEDO = open("../JSON/documentoGEDO.json")
      #datosGEDO = archivoDatosGEDO.read
      #datosGEDOParseo = JSON.parse(datosGEDO)
      #self.setAcronimo(datosGEDOParseo["documentoGEDO"]["acronimo"])
      #self.setReferencia(datosGEDOParseo["documentoGEDO"]["referencia"])
      #self.setPassword(datosGEDOParseo["login"]["usuario"]["password"])
    #end
    # Getters
    def getFFCC
      return @ffcc
    end
    def getBrowser
      return @browser
    end
    def getAcronimo
      return @acronimo
    end
    def getPassword
      return @password
    end
    def getReferencia
      return @referencia
    end
    def getRutaImportado
      return @rutaImportado
    end
    def getRutaEmbebido
      return @rutaEmbebido
    end
    # 
    def getDatosGEDOParseo
      return @datosGEDOParseo
    end
    # Getters botones
    def getBoton_archivo_trabajo_confec
      return @boton_archivo_trabajo_confec
    end
    def getBoton_enviar_producir
      return  @boton_enviar_producir
    end
    def getBoton_producir_yo_mismo
      return @boton_producir_yo_mismo
    end
    def getBoton_enviar_prod_confec
      return @boton_enviar_prod_confec
    end
    def getBoton_destinatarios_confec
      return @boton_destinatarios_confec
    end
    def getBoton_archivos_trabajo_prod
      return @boton_archivos_trabajo_prod
    end
    def getBoton_firmar_yo_mismo_prod
      return @boton_firmar_yo_mismo_prod
    end
    #
    def getBoton_firmar_certificado
      return @boton_firmar_certificado
    end
    #
    def getBoton_volver_buzon_tareas
      return @boton_volver_buzon_tareas
    end
    # Setters
    def setRutaImportado(rutaImportado)
      @rutaImportado = rutaImportado
    end
    def setRutaEmbebido(rutaEmbebido)
      @rutaEmbebido = rutaEmbebido
    end
    def setFFCC(ffcc)
      @ffcc = ffcc
    end
    def setUrlModulo(urlModulo)
      @urlModulo = urlModulo
    end
    def setUsuario(usuario)
      @usuario = usuario
    end
    def setPassword(password)
      @password = password
    end
    def setAcronimo(acronimo)
      @acronimo = acronimo
    end
    def setReferencia(referencia)
      @referencia = referencia
    end
    def setBrowser(browser)
      @browser = browser
    end
    def setDatosGEDOParseo(datosGEDOParseo)
      @datosGEDOParseo = datosGEDOParseo
    end
    # Botones
    def setBoton_archivo_trabajo_confec(boton_archivo_trabajo_confec)
      @boton_archivo_trabajo_confec = boton_archivo_trabajo_confec
    end
    def setBoton_enviar_producir(boton_enviar_producir)
      @boton_enviar_producir = boton_enviar_producir
    end
    def setBoton_producir_yo_mismo(boton_producir_yo_mismo)
      @boton_producir_yo_mismo = boton_producir_yo_mismo
    end
    def setBoton_enviar_prod_confec(boton_enviar_prod_confec)
      @boton_enviar_prod_confec = boton_enviar_prod_confec
    end
    def setBoton_destinatarios_confec(boton_destinatarios_confec)
      @boton_destinatarios_confec = boton_destinatarios_confec
    end
    def setBoton_archivos_trabajo_prod(boton_archivos_trabajo_prod)
      @boton_archivos_trabajo_prod = boton_archivos_trabajo_prod
    end
    def setBoton_firmar_yo_mismo_prod(boton_firmar_yo_mismo_prod)
      @boton_firmar_yo_mismo_prod = boton_firmar_yo_mismo_prod
    end
    def setBoton_firmar_certificado(boton_firmar_certificado)
      @boton_firmar_certificado = boton_firmar_certificado
    end
    #
    # Métodos
    # Las subclases deberían implementar su producción además de utilizar este método complementario
    def iniciarProduccionDocumento
      #Inicio del documento
      #log.info("Inicio del documento")    
      getBrowser().div(:class => 'z-toolbarbutton').click
      #Espera a que se cargue el popup de inicio de documento
      #log.info("Espera a que se cargue el popup de inicio de documento")    
      Watir::Wait.until { getBrowser().text_field(:class => 'z-bandbox-inp').exists?}
      #log.info("Popup de inicio de documento: Cargado")  
      #TIPO DE DOCUMENTO A PRODUCIR
      # b.text_field(:class => 'z-bandbox-inp').set 'TMAUT'
      getBrowser().text_field(:class => 'z-bandbox-inp').set getAcronimo()
      getBrowser().text_field(:class => 'z-bandbox-inp').fire_event :blur
      #
      self.parsearBotonesInciarProduccionDocumento()
    end
    # Se parsean todos las imagenes que derivan eb botones del popup Iniciar Producción de Documento
    def parsearBotonesInciarProduccionDocumento
      #Obtener todas imagenes del popup "Iniciar Producción de Documento"
      botonesImagenes = self.getBrowser().div(:class => 'z-window-highlighted-cl').images
      botonesImagenes.each do |imagen|
        rutaImagenSplit = imagen.src.split('/')
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        if nombreImagen ==  ARCHIVO_TRABAJO_CONFECCION
          self.setBoton_archivo_trabajo_confec(imagen)
        end
        if nombreImagen ==  DESTINATARIOS_CONFECCION
          self.setBoton_destinatarios_confec(imagen)
        end
        if nombreImagen ==  ENVIAR_PRODUCIR_CONFECCION
          self.setBoton_enviar_prod_confec(imagen)
        end
        if nombreImagen ==  PRODUCIR_YO_MISMO_CONFECCION
          self.setBoton_producir_yo_mismo(imagen)
        end
      end
    end
    #Realiza submit sobre el popup de inicio de documento
    def producir_yo_mismo
      self.getBoton_producir_yo_mismo().click
      # TO DO Ver de Bloquear hasta que no finalice la ejecución del submit
    end
    #Realiza submit sobre el popup de producir documento
    def firmar_yo_mismo_prod
      self.getBoton_firmar_yo_mismo_prod().click
      # Bloquea hasta que no finalice la ejecución del submit
      self.getBoton_firmar_yo_mismo_prod().wait_while_present
      # Una vez cargada la pantalla de Firma de Documento se parsean los botones
      self.parsearBotonesFirmarDocumento()
    end
    #Realiza la confección propiamente dicha, cada documento tiene su forma de confeccionarse
#    def producirDocumento
      #Cada documento debe implementar su manera de producir
#    end
    # Se encarga de importar un archivo de PC al documento que se está confeccionando
    def importarArchivo
      self.getBrowser().file_field(:name => 'file').set(self.getRutaImportado())
    end
    # Se completa de manera diferente si se trata de un documento de tipo distinto de libre
    def completarReferencia(referencia)
      # Se aguarda que cargue correctamente la pantalla de Producir documento
      self.getBrowser().text_field(:class => 'z-bandbox-inp').wait_while_present
      # Se completa la referencia
      # Obtener todos los inputs text y filtar los que no son visible
      # Completa todos los campos que existen
      indice = 0
      campos = self.getBrowser().text_fields(:class => 'z-textbox')  
      campos.each do |i|
        indice = indice + 1
        if i.visible?
          if indice == POSICIONREFERENCIA 
            i.set referencia
          #else
            #if indice > POSICIONREFERENCIA
            #  i.set TEXTOCAMPOSFC
            #end  
          end
          i.fire_event :blur
        end
      end
    end

    # Completa los campos del FFCC
    # TO DO - Analizar la forma de poder procesar un JSON o alguna estructura de datos mejor
    def completarFFCC
      indice = 0 # TO DO: Luego validar si se utiliza esta variable o se puede eliminar
      indiceFFCC = 0
      campos = self.getBrowser().text_fields(:class => 'z-textbox')  
      campos.each do |i|
        indice = indice + 1
        if i.visible?
          if indice > POSICIONREFERENCIA
            #i.set TEXTOCAMPOSFC
            #puts "0---------------"
            i.set self.getFFCC()[indiceFFCC.to_s]
            #puts "1---------------"
            indiceFFCC = indiceFFCC + 1
          end
          i.fire_event :blur
        end
      end
    end
    # Se parsen todos los botones del popup Producir Documento
    def parsearBotonesProducirDocumento
      #SE PARSEAN LAS IMAGENES QUE DERIVAN EN BOTONES
      #  boton_archivos_embebidos = nil
      #tab_archivos_embebidos = nil
      #Obtener todas imagenes del popup "Iniciar Producción de Documento"
      #PRESIONA EL BOTÓN - 'ProducirloYoMismo.png'
      botonesImagenes = getBrowser().div(:class => 'z-window-highlighted-cl').images
      botonesImagenes.each do |imagen|
        rutaImagenSplit = imagen.src.split('/')
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        #puts pic
        #if pic == 'ProducirloYoMismo.png'
        if nombreImagen ==  HISTORIAL
          @boton_historial = imagen
        end
        if nombreImagen ==  ENVIAR_REVISAR_PROD
          @boton_enviar_revisar_prod = imagen
        end
        if nombreImagen ==  ENVIAR_FIRMAR_PROD
          @boton_enviar_firmar_prod = imagen
        end
        if nombreImagen ==  FIRMAR_YO_MISMO_PROD
          #@boton_firmar_yo_mismo_prod 
          self.setBoton_firmar_yo_mismo_prod(imagen)
        end
      end
    end
    # Se parsean todos los botones del popup Firma De Documento
    def parsearBotonesFirmarDocumento
      #SE PARSEAN LAS IMAGENES QUE DERIVAN EN BOTONES
      #  boton_archivos_embebidos = nil
      #tab_archivos_embebidos = nil
      #Obtener todas imagenes del popup "Iniciar Producción de Documento"
      #PRESIONA EL BOTÓN - 'ProducirloYoMismo.png'
      botonesImagenes = getBrowser().div(:class => 'z-window-highlighted-cl').images
      botonesImagenes.each do |imagen|
        rutaImagenSplit = imagen.src.split('/')
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        #puts pic
        #TO DO getters / setters
        if nombreImagen ==  HISTORIAL
          @boton_historial = imagen
        end
        if nombreImagen ==  ENVIAR_REVISAR_PROD
          @boton_enviar_revisar_prod = imagen
        end
        if nombreImagen ==  ENVIAR_FIRMAR_PROD
          @boton_enviar_firmar_prod = imagen
        end
        if nombreImagen ==  FIRMAR_CERTIFICADO
          self.setBoton_firmar_certificado(imagen)
        end
      end
    end
    # Se realiza la firma de un documento GEDO con Certificado
    def firmaDeDocumentoConCertificado
      self.getBoton_firmar_certificado().click
      # Bloquea hasta que no finalice la ejecución del submit
      self.getBoton_firmar_certificado().wait_while_present
    end
    # Se realiza la firma de un documento GEDO que posee embebidos con Certificado
    def firmaDeDocumentoConEmbebidosConCertificado
      # Cierra el popup de aviso de documento con archivos embebidos
      self.getBrowser().div(:class => 'z-window-highlighted-close').click
      self.parsearBotonesFirmarDocumento()
      # Se vuelen a parsear los botones
      self.getBoton_firmar_certificado().click
      # Bloquea hasta que no finalice la ejecución del submit
      self.getBoton_firmar_certificado().wait_while_present
    end
    # Se crea un elemento div provisorio dinámico para poder copiar el código SADE generado
    def copiarCodigoSadeGenerado
      self.getBrowser().execute_script("$('body').append('<div id =\"log\" ></div>'); $('#log').text($($('span').get($('span').size() - 2)).text())")
      # Se loguea el código SADE del documento generado - Falta Getter
      @log.info(self.getBrowser().div(:id => 'log').text())
      # Se realiza captura del código SADE generado
      self.realizarCapturaDePantalla()
      #Eliminar el DIV generado dinámicamente
      self.getBrowser().execute_script("$('#log').remove()")
    end
    # 
    def parsearBotonesDescargarVolverBuzonTareas
      #PRESIONA EL BOTÓN - 'VolverAlBuzonTareas.png'
      pics = self.getBrowser().div(:class => 'z-window-highlighted-cl').images
      pics.each do |img|
        sp = img.src.split('/')
        pic = sp[sp.length - 1]
        #puts pic
        if pic == VOLVER_BUZON_TAREAS
          @boton_volver_buzon_tareas = img
          #img.click
        end   
      end
      #PRESIONA EL BOTÓN - 'ProducirloYoMismo.png'
      #botonesImagenes = self.getBrowser().div(:class => 'z-window-highlighted-cl').images
      #botonesImagenes.each do |imagen|
        #rutaImagenSplit = imagen.src.split('/')
        #nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        #puts pic
        #TO DO getters / setters
        #if nombreImagen ==  VOLVER_BUZON_TAREAS
          #@boton_volver_buzon_tareas = imagen
        #end
        #if nombreImagen ==  DESCARGAR_DOCUMENTO
          #@boton_descargar_documento = imagen
        #end
      #end
    end
    # Volver al buzón de tareas
    def volverBuzonDeTareas
      self.parsearBotonesDescargarVolverBuzonTareas()
      self.getBoton_volver_buzon_tareas().click
      # Bloquea hasta que no finalice la ejecución del submit
      self.getBoton_volver_buzon_tareas().wait_while_present
    end
    # Embeber archivos
    def embeberArchivo
      # IMPORTAR UNA IMAGEN en TAB PRODUCCIÓN
      tab_archivos_embebidos = nil
      #Busca la imagen del TAB - 'Archivos embebidos'
      pics = self.getBrowser().div(:class => 'z-window-highlighted-cl').images
        pics.each do |img|
        sp = img.src.split('/')
        pic = sp[sp.length - 1]
        #puts pic
        #if pic == 'ProducirloYoMismo.png'
        if pic ==  TAB_ARCHIVO_EMBEBIDO
          @tab_archivos_embebidos = img
        end
      end
      # Se presiona el botón del TAB de achivos embebidos
      @tab_archivos_embebidos.click
      # Setea el archivo embebido
      inputs_file = self.getBrowser().file_fields(:name => 'file')
      inputs_file[1].set(self.getRutaEmbebido())
    end
    # Cada subclase implementará el modo de producirDocumento()
    def producirDocumentoConEmbebidos()
      # Cada documento implementa su manera de producir
      self.producirDocumento()
      # Invovaca al método que sube el archivo embebido
      self.embeberArchivo()
    end
    # Tomar captura de pantalla
    def realizarCapturaDePantalla
      self.getBrowser().screenshot.save("#{GEDORUTASCREENSHOT}GEDO_#{DateTime.now.strftime("%Y-%b-%d_%H%M%S")}.png")
    end
  end
###############################################################################