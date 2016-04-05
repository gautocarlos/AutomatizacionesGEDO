# Clase que se utiliza para dar de alta un nuevo documento GEDO del tipo libre#
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require '../constantes.rb'
  class Expediente
    attr_accessor
      :browser
      :log
      :trata
      :motivoInterno
      :motivoExterno
      :descAdicional
      :ffcc
      :tipoActuacion
      :anio
      :numero
      :reparticionActuacion
      :reparticionUsuario
      :botoneraEEParseo
      :datosExpediente
    # constructor
    def initialize(browser)
      #@browser = browser
      self.setBrowser(browser)
      #@acronimo = acronimo
      log = Logger.new('C:\CapturasWatir\Logs\Logs.txt') #DEBUG
      #@log = Logger.new("#{GEDORUTALOGS}#{GEDONOMBRELOG}")
      self.setLog(log)
      #self.
      parseJSON()
    end
    # Getters
    def getDatosExpediente()
      return @datosExpediente
    end
    #
    def getBrowser()
      return @browser
    end
    # 
    def getLog()
      return @log
    end
    #
    def getTrata()
      return @trata
    end
    #
    def getMotivoInterno()
      return @motivoInterno
    end
    #
    def getMotivoExterno()
      return @motivoExterno
    end
    #
    def getDescAdicional()
      return @descAdicional
    end
    # 
    def getFFCC
      return @ffcc
    end
    #
    def getTipoActuacion()
      return @tipoActuacion
    end
    #
    def getAnio()
      return @anio
    end
    #
    def getNumero()
      return @numero
    end
    #
    def getReparticionActuacion()
      return @reparticionActuacion
    end
    # 
    def getReparticionUsuario()
      return @reparticionUsuario
    end
    # 
    def getBotoneraEEParseo()
      return @botoneraEEParseo 
    end
    # Setters
    def setDatosExpediente(datosExpediente)
      @datosExpediente = datosExpediente
    end

    def setBrowser(browser)
      @browser = browser
    end
    #
    def setLog(log)
      @log = log
    end
    def setTrata(trata)
      @trata = trata
    end
    #
    def setMotivoInterno(motivoInterno)
      @motivoInterno = motivoInterno
    end
    #
    def setMotivoExterno(motivoExterno)
      @motivoExterno = motivoExterno
    end
    #
    def setDescAdicional(descAdicional)
      @descAdicional = descAdicional
    end
    #
    def setFFCC(ffcc)
      @ffcc = ffcc
    end
    #
    def setTipoActuacion(tipoActuacion)
      @tipoActuacion = tipoActuacion
    end
    #
    def setAnio(anio)
      @anio = anio
    end
    #
    def setNumero(numero)
      @numero = numero
    end
    #
    def setReparticionActuacion(reparticionActuacion)
      @reparticionActuacion = reparticionActuacion
    end
    # 
    def setReparticionUsuario(reparticionUsuario)
      @reparticionUsuario = reparticionUsuario
    end
    #
    def setBotoneraEEParseo (botoneraEEParseo)
      @botoneraEEParseo = botoneraEEParseo
    end
    # Métodos
    def parseJSON()
      archivoDatosEE = open("../JSON/expediente.json")
      datosEE = archivoDatosEE.read
      datosEEParseo = JSON.parse(datosEE)
      # TO DO
      # Se debe reemplazar esta implementación para que cada método acceda directo al contenido del JSON sin guardarlo en variables
      self.setDatosExpediente(datosEEParseo)
      # Se debe reemplazar esta implementación para que cada método acceda directo al contenido del JSON sin guardarlo en variables
      # TO DO
      self.setTrata(datosEEParseo["expediente"]["trata"])
      self.setMotivoInterno(datosEEParseo["expediente"]["motivoInterno"])
      self.setMotivoExterno(datosEEParseo["expediente"]["motivoExterno"])
      self.setDescAdicional(datosEEParseo["expediente"]["descAdicional"])
      if (datosEEParseo["expediente"]["ffcc"] != nil)
        self.setFFCC(datosEEParseo["expediente"]["ffcc"])
      end
    end
    # Métodos
    # Todos los nombres de las imagenes que se contraponen con botones de EE se parametrizan via JSON
    def parseJSONBotonerasEE()
      archivoBotoneraEE = open("../JSON/botoneraExpediente.json")
      botoneraEE = archivoBotoneraEE.read
      botoneraEEParseo = JSON.parse(botoneraEE)
      self.setBotoneraEEParseo(botoneraEEParseo)
    end
    # Completa los datos de la caratula variable
    def completarFFCC()
      indice = 0 # TO DO: Luego validar si se utiliza esta variable o se puede eliminar
      indiceFFCC = 0
      campos = self.getBrowser().text_fields(:class => 'z-textbox')  
      campos.each do |i|
        indice = indice + 1
        if (i.visible? && !i.readonly?)
          if indice > 0
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

    # Realiza una caratulación interna de expediente
    def caratularInterno()
      self.iniciarCaratulacionInterna()
      self.completarDatosGenericos()
      self.caratular()
      #self.getBrowser().text_field(:class => 'z-bandbox-inp').wait_while_present
      #self.getBrowser().div(:class => 'z-loading-indicator').wait_while_present
      #Watir::Wait.until { self.getBrowser().element(:class => 'z-button-cm').exists?}
      if(self.tieneCaratulaVariable())
        self.completarCV()
      end
      #
      #if (self.getBrowser().fieldset(:class => 'z-fieldset').exists?)
        #puts "------------- Tiene caratula variable, Completar -------------"
      #end
      self.terminarCaratulacion()
    end
    # Realiza una caratulación interna de expediente
    def caratularExterno()
      self.getBrowser().divs(:class => 'z-toolbarbutton-cnt')[2].click

    end
    #
    def iniciarCaratulacionInterna()
      self.getBrowser().divs(:class => 'z-toolbarbutton-cnt')[1].click 
    end
    #
    def iniciarCaratulacionExterna()
      self.getBrowser().divs(:class => 'z-toolbarbutton-cnt')[2].click 
    end
    # 
    def completarDatosGenericos()
      Watir::Wait.until { self.getBrowser().text_fields(:class => 'z-textbox')[0].exists?}
      self.getBrowser().text_fields(:class => 'z-textbox')[0].set self.getMotivoInterno()
      self.getBrowser().text_fields(:class => 'z-textbox')[1].set self.getMotivoExterno()
      self.getBrowser().text_field(:class => 'z-bandbox-inp').set self.getTrata()
      self.getBrowser().text_field(:class => 'z-bandbox-inp').fire_event :blur
      self.getBrowser().text_fields(:class => 'z-textbox')[2].set self.getDescAdicional()
      # Selecciona la trata
      #self.getBrowser().element(:class => 'z-modal-mask').click
    end
    # 
    def completarDatosPersonaFisica()

    end
    #
    def caratular()
      # Caratular
      #self.getBrowser().execute_script("($('.z-toolbarbutton').get(3)).click()")
      #puts "----caratular()----"
      self.getBrowser().divs(:class => 'z-toolbarbutton')[3].click
      self.getBrowser().divs(:class => 'z-toolbarbutton')[3].wait_while_present
    end
    def tieneCaratulaVariable()
      #puts "tieneCaratulaVariable"
      return (self.getBrowser().fieldset(:class => 'z-fieldset').exists?)
    end
    #
    def completarCV()
        self.completarFFCC()
        #puts "----completarFFCC()----"
        self.getBrowser().element(:class => 'z-button-cm').click
        #self.getBrowser().element(:class => 'z-button-cm').wait_while_present
        self.getBrowser().fieldset(:class => 'z-fieldset').wait_while_present
    end
    #
    def terminarCaratulacion()
      #puts "----terminarCaratulacion()----"
      self.getBrowser().element(:class => 'z-button-cm').click
    end
    # Deprecar?
    def consultarEE()
      self.presionarTabConsulta()

    end
    #
    def consultaExpedientesPorNumeroSADE(anio, numero, reparticionUsuario)
      self.presionarTabConsulta()
      self.presionarBotonConsultaExpedientesPorNumeroSADE()
      self.cargarNumeroSADEExpedienteConsulta(anio, numero, reparticionUsuario)
      self.presionarBotonBuscarExpediente()
    end
    #
    def presionarTabConsulta()
      botonera = self.getBrowser().spans(:class => 'z-tab-text') 
      botonera.each do |boton|
        if (boton.text == "Consultas")
          boton.click
        end
      end
    end
    #
    def presionarBotonConsultaExpedientesPorNumeroSADE()
      self.getBrowser().button(:class => 'z-menu-item-btn').click
    end
    #
    def presionarBotonBuscarExpediente()
      self.getBrowser().spans(:class => 'z-button')[1].click()
    end
    #
    def cargarNumeroSADEExpedienteConsulta(anio, numero, reparticionUsuario)
      self.getBrowser().text_fields(:class => 'z-intbox')[0].set anio
      self.getBrowser().text_fields(:class => 'z-intbox')[1].set numero
      #self.getBrowser().text_fields(:class => 'z-bandbox-btn')[1].set numero
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].set reparticionUsuario
    end
    #
    def visualizarExpediente()
      imagenes = self.getBrowser().images
      imagenes.each do |imagen|
        if imagen.title == "Ver expediente"
          imagen.click
        end
      end
    end
    #
    def consultasPresionarTramitar()
      botonera = self.getBrowser().spans(:class => 'z-label')
      #botonConsulta = nil
      botonera.each do |boton|
        if (boton.title == "Tramitar Expediente")
          #botonConsulta = boton
          boton.click
          break
        end
      end
      #botonConsulta.wait_while_present
    end
    #
    def tramitarEjecutarTarea()
      consultasPresionarTramitar()      
      Watir::Wait.until { (self.getBrowser().lis(:class => 'z-menu-item')[8]).exists?}
      self.getBrowser().lis(:class => 'z-menu-item')[8].click
    end
    #
    def tramitarAdquirirTarea()
      consultasPresionarTramitar()
      Watir::Wait.until { (self.getBrowser().lis(:class => 'z-menu-item')[9]).exists?}
      self.getBrowser().lis(:class => 'z-menu-item')[9].click
    end    
    # Realizar Pase manteniendo el mismo estado que posee actualmente el EE. Destino usuario:
    def realizarPaseSinCambioEstadoDestinoUsuario(motivoPase)
      self.parseJSONBotonerasEE()
      botoneraEE = self.getBotoneraEEParseo()
      self.presionarBoton(botoneraEE['botonera']['transversal']['RealizarPase'])
      self.seleccionarDestinoUsuario()
      #self.seleccionarDestinoSector()
      self.cargarDestinoUsuario()
    end
    # Realizar Pase manteniendo el mismo estado que posee actualmente el EE. Destino Reparticion-Sector:
    def realizarPaseSinCambioEstadoDestinoSector(motivoPase)
      self.parseJSONBotonerasEE()
      botoneraEE = self.getBotoneraEEParseo()
      self.presionarBoton(botoneraEE['botonera']['transversal']['RealizarPase'])
      #
      self.completarMotivoPase(motivoPase)
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
    end
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    def presionarBoton(nombreBoton)
      #Obtener todas imagenes que sean botones
      Watir::Wait.until { (self.getBrowser().div(:class => 'z-window-highlighted-cnt')).exists?}
      botonesImagenes = self.getBrowser().div(:class => 'z-window-highlighted-cnt').images
      botonesImagenes.each do |boton|
        rutaImagenSplit = boton.src.split('/')
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        #botoneraEE = self.getBotoneraEEParseo()
        #
        #if nombreImagen == botoneraEE['botonera']['transversal']['RealizarPase']
        if nombreImagen == nombreBoton
          boton.click
        end
      end
    end
    # 
    def seleccionarDestinoUsuario()
      #Watir::Wait.until { (self.getBrowser().spans(:class => 'z-radio')[2]).exists?}
      self.getBrowser().spans(:class => 'z-radio')[2].click
    end
    # 
    def seleccionarDestinoSector()
      #Watir::Wait.until { (self.getBrowser().spans(:class => 'z-radio')[2]).exists?}
      self.getBrowser().spans(:class => 'z-radio')[3].click
    end
    # 
    def seleccionarDestinoMesaDeLaReparticion()
      #Watir::Wait.until { (self.getBrowser().spans(:class => 'z-radio')[2]).exists?}
      self.getBrowser().spans(:class => 'z-radio')[4].click
    end
    # 
    def cargarDestinoUsuario()
      
    end
    # 
    def cargarDestinoSector()
      # Levantar del JSON
      datosExpediente = self.getDatosExpediente()
      (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5]).set datosExpediente['expediente']['pase']['sectorDestino']['reparticion']
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5].fire_event :blur
      (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[6]).set datosExpediente['expediente']['pase']['sectorDestino']['sector']
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[6].fire_event :blur
      #expediente.getBrowser().text_field(:class => 'z-bandbox-inp')[5]
    end
    # 
    def cargarDestinoMesaDeLaReparticion()
      
    end
    # 
    def completarMotivoPase(motivoPase)
      # Completar el texto libre del documento GEDO
      self.getBrowser().execute_script("$($('iframe').get(1)).contents().find('body').append('<p>#{motivoPase}</p>')")
    end
    #
  end
###############################################################################