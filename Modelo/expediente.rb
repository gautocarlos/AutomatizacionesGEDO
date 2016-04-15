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
      :expedientePasesJSON
    # constructor
    def initialize(browser)
      self.setBrowser(browser)
      log = Logger.new('C:\CapturasWatir\Logs\Logs.txt') #DEBUG
      #@log = Logger.new("#{GEDORUTALOGS}#{GEDONOMBRELOG}")
      self.setLog(log)
      parseJSON()
      self.parseJSONBotonerasEE()
    end
    # Getters
    def getExpedientePasesJSON()
      return @expedientePasesJSON
    end
    #
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
    def setExpedientePasesJSON(expedientePasesJSON)
      @expedientePasesJSON = expedientePasesJSON
    end
    #
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
      # Se parsea el archivo con la información de los pases
      archivoexpedientePases = open("../JSON/expedientePases.json")
      expedientePasesJSON = archivoexpedientePases.read
      expedientePasesJSONParse = JSON.parse(expedientePasesJSON)
      # TO DO
      # Se debe reemplazar esta implementación para que cada método acceda directo al contenido del JSON sin guardarlo en variables
      self.setExpedientePasesJSON(expedientePasesJSONParse)
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
            i.set self.getFFCC()[indiceFFCC.to_s]
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
      if(self.tieneCaratulaVariable())
        self.completarCV()
      end
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
      self.getBrowser().divs(:class => 'z-toolbarbutton')[3].click
      self.getBrowser().divs(:class => 'z-toolbarbutton')[3].wait_while_present
    end
    def tieneCaratulaVariable()
      return (self.getBrowser().fieldset(:class => 'z-fieldset').exists?)
    end
    #
    def completarCV()
        self.completarFFCC()
        self.getBrowser().element(:class => 'z-button-cm').click
        self.getBrowser().fieldset(:class => 'z-fieldset').wait_while_present
    end
    #
    def terminarCaratulacion()
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
      #self.getBrowser().spans(:class => 'z-button')[1].click() # Dejó de funcionar sin razón aparente
      #self.getBrowser().tds(:class => 'z-button-cm')[1].click()
      botonera = self.getBrowser().tds(:class => 'z-button-cm') 
      botonera.each do |boton|
        if (boton.text() == "Buscar")
          boton.click
          break
        end
      end

    end
    #
    def cargarNumeroSADEExpedienteConsulta(anio, numero, reparticionUsuario)
      self.getBrowser().text_fields(:class => 'z-intbox')[0].set anio
      self.getBrowser().text_fields(:class => 'z-intbox')[0].fire_event :blur
      self.getBrowser().text_fields(:class => 'z-intbox')[1].set numero
      self.getBrowser().text_fields(:class => 'z-intbox')[1].fire_event :blur
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].set reparticionUsuario
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[0].fire_event :blur
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
      botonEjecutar = self.getBrowser().lis(:class => 'z-menu-item')[8] #.click
      botonEjecutar.click
      botonEjecutar.wait_while_present
    end
    #
    def tramitarAdquirirTarea()
      self.consultasPresionarTramitar()
      Watir::Wait.until { (self.getBrowser().lis(:class => 'z-menu-item')[9]).exists?}
      botonAdquirir = self.getBrowser().lis(:class => 'z-menu-item')[9]
      botonAdquirir.click
      botonAdquirir.wait_while_present
    end
    #
    def tramitarAdquirirTareaEjecutar()
      #consultasPresionarTramitar()
      #Watir::Wait.until { (self.getBrowser().lis(:class => 'z-menu-item')[9]).exists?}
      #botonAdquirir = self.getBrowser().lis(:class => 'z-menu-item')[9]
      #botonAdquirir.click
      #botonAdquirir.wait_while_present
      botoneraEE = self.getBotoneraEEParseo()
      self.tramitarAdquirirTarea()
      # FALTA UN WAIT, NO LLEGA A CARGAR EL BOTON POR ESO FALLA
      boton = self.presionarBotonImagen(botoneraEE['botonera']['botonesInternos']['Ejecutar'], 0)
      boton.wait_while_present
    end
    # Presiona el botón de realizar pase de la botonera transversal de la tramitación de expediente
    def presionarRealizarPaseBotoneraTransversal()
      botoneraEE = self.getBotoneraEEParseo()
      boton = self.presionarBotonImagen(botoneraEE['botonera']['transversal']['RealizarPase'], 0)      
    end
    # Presiona el botón de realizar pase de la pantalla propia de realizar pase
    def presionarRealizarPase()
      botoneraEE = self.getBotoneraEEParseo()
      boton = self.presionarBotonImagen(botoneraEE['botonera']['transversal']['RealizarPase'], 1)
    end
    #
    # Realizar Pase manteniendo el mismo estado que posee actualmente el EE. Destino usuario:
    def realizarPaseSinCambioEstadoDestinoUsuario(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      self.presionarRealizarPase()
    end
    # Realizar Pase manteniendo el mismo estado que posee actualmente el EE. Destino Reparticion-Sector:
    def realizarPaseSinCambioEstadoDestinoSector(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      self.presionarRealizarPase()
    end
    # Realizar Pase manteniendo el mismo estado que posee actualmente el EE. Destino: Mesa de la repartición
    def realizarPaseSinCambioEstadoDestinoMesaDeLaReparticion(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      self.presionarRealizarPase()
    end
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    def presionarBotonImagen(nombreBoton)
      #Obtener todas imagenes que sean botones
      Watir::Wait.until { (self.getBrowser().div(:class => 'z-window-highlighted-cnt')).exists?}
      botonesImagenes = self.getBrowser().div(:class => 'z-window-highlighted-cnt').images
      botonesImagenes.each do |boton|
        rutaImagenSplit = boton.src.split('/')
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        if ((nombreImagen == nombreBoton) && (boton.visible?) && (boton.present?))
          begin
              boton.click
              break
          rescue
            puts "Hubo un error al dar click en el botón y/o el mismo no es visible."
          end          
        end
        #
      end
    end
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    def presionarBotonTD(textoBoton, clase)
      # Redefinir la variable clase para recibir por parámetro la clase del componente a presionar click
      #clase = 'z-button-cm'
      botonera = self.getBrowser().tds(:class => clase)
      botonera.each do |boton|
        if (boton.text() == textoBoton)
          boton.click
          break
        end
      end
      #botonConsulta.wait_while_present
    end
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    def presionarBotonImagen(nombreBoton, indiceFrame)
      #Obtener todas imagenes que sean botones
      Watir::Wait.until { (self.getBrowser().div(:class => 'z-window-highlighted-cnt')).exists?}
      botonesImagenes = (self.getBrowser().divs(:class => 'z-window-highlighted-cnt'))[indiceFrame].images
      botonPresionado = nil
      botonesImagenes.each do |boton|
        rutaImagenSplit = boton.src.split('/')
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        if ((nombreImagen == nombreBoton) && (boton.visible?) && (boton.present?))
          begin
              boton.click
              botonPresionado = boton
              break
          rescue
            puts "Hubo un error al dar click en el botón y/o el mismo no es visible."
          end          
        end
        #
      end
      return botonPresionado
    end
    def seleccionarDestinoUsuario()
      Watir::Wait.until { (self.getBrowser().spans(:class => 'z-radio')[2]).exists?}
      self.getBrowser().spans(:class => 'z-radio')[2].click
    end
    # 
    def seleccionarDestinoSector()
      Watir::Wait.until { (self.getBrowser().spans(:class => 'z-radio')[3]).exists?}
      self.getBrowser().spans(:class => 'z-radio')[3].click
    end
    # 
    def seleccionarDestinoMesaDeLaReparticion()
      Watir::Wait.until { (self.getBrowser().spans(:class => 'z-radio')[4]).exists?}
      self.getBrowser().spans(:class => 'z-radio')[4].click
    end
    # 
    def cargarDestinoUsuario()
      datosExpediente = self.getDatosExpediente()
      sleep 1
      campoUsuario = self.getBrowser().text_fields(:class => 'z-combobox-inp')
      indice = 1
      campoUsuario.each do |inputUsuario|
        if (inputUsuario.visible?)
          begin
            #puts "indice:: #{indice} :: inputUsuario.visible"
            inputUsuario.set datosExpediente['expediente']['pase']['usuarioDestino']
            break
            rescue 
              puts "No se puede cargar el usuarioDestino en este input."
          end          
        end
      end
      sleep 2
      self.getBrowser().execute_script("$('.z-comboitem-text').get($('.z-comboitem-text').size()-1).click()")
      sleep 2
    end
    # 
    def cargarDestinoSector()
      # Levantar del JSON
      datosExpediente = self.getDatosExpediente()
      sleep 2 # Agregar un wait que evalue si el campo está habilitado o no
      (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5]).set datosExpediente['expediente']['pase']['sectorDestino']['reparticion']
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[5].fire_event :blur
      (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[6]).set datosExpediente['expediente']['pase']['sectorDestino']['sector']
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[6].fire_event :blur
    end
    # 
    def cargarDestinoMesaDeLaReparticion()
      datosExpediente = self.getDatosExpediente()
      posicion = (self.getBrowser().text_fields(:class => 'z-bandbox-inp')).size() - 2
      sleep 1
      (self.getBrowser().text_fields(:class => 'z-bandbox-inp')[posicion]).set datosExpediente['expediente']['pase']['mesaDeLaReparticion']
      self.getBrowser().text_fields(:class => 'z-bandbox-inp')[posicion].fire_event :blur
    end
    #
    def completarMotivoPase(motivoPase)
      # Completar el motivo del Pase
      scriptOld = "$($('iframe').get(1)).contents().find('body').find('iframe').contents().find('body').append('<p>#{motivoPase}</p>')"
      scriptNew = "
      marcos = $('iframe')
      for (i = 0; i < marcos.size(); i++)
      {
        srcUnFrame = marcos.get(i).src
        if ((srcUnFrame != null) && (srcUnFrame.contains('FCKeditor'))) {
           console.log(srcUnFrame)
           console.log(i)
           $($('iframe').get(i)).contents().find('body').find('iframe').contents().find('body').append('<p>#{motivoPase}</p>')
        }
      };"      
      self.getBrowser().execute_script(scriptNew)
    end
    # Métodos para relizar un pase cambiando el destino
    def paseDestinoIniciacion(obsoleto)
      expedientePasesJSON = self.getExpedientePasesJSON()
      indice = 0
      estadoIniciacion = 'Iniciación'
      existeEstado = false
      comboEstadoActual = self.getBrowser().text_fields(:class => 'z-combobox-inp z-combobox-readonly')
      comboEstadoActual.each do |estado|
        indice = indice + 1
        if ((estado.visible?) && ((estado.value() != nil) || (estado.value() != '')) && (estado.value() == estadoIniciacion))
          existeEstado = true
          break
        end
      end
      if !(existeEstado)
        # Implementar raise
        puts "paseDestinoIniciacion() - ERROR NO EXISTE EL ESTADO SELECCIONADO COMO DESTINO DE PASE."
        return
      end
    end
    #
    def paseDestinoIniciacion()
      destinoPase = 'Iniciación'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseInciacion()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      if (comboEstado != nil)      
        # Existe el destino seleccionado
        #self.seleccionarDestinoTramitacion(comboEstado)
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    # Método principal de realización de pase a Tramitación
    def paseDestinoTramitacion()
      destinoPase = 'Tramitación'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseTramitacion()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      if (comboEstado != nil)      
        # Existe el destino seleccionado
        #self.seleccionarDestinoTramitacion(comboEstado)
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    def paseDestinoComunicacion()
      destinoPase = 'Comunicación'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseComunicacion()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      if (comboEstado != nil)      
        # Existe el destino seleccionado
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    def paseDestinoEjecucion()
      destinoPase = 'Ejecución'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseEjecucion()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      if (comboEstado != nil)      
        # Existe el destino seleccionado
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    def paseDestinoSubsanacion()
      destinoPase = 'Subsanación'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseSubsanacion()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      if (comboEstado != nil)      
        # Existe el destino seleccionado
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    def paseDestinoGuardaTemporal()
      destinoPase = 'Guarda Temporal'
      expedientePasesJSON = self.getExpedientePasesJSON()
      estadosValidos = self.estadosValidosPaseGuardaTemporal()
      comboEstado = self.validarEstadoExpedienteParaPase(estadosValidos)
      #puts ":: paseDestinoGuardaTemporal() ::  (comboEstado != nil) ::"
      if (comboEstado != nil)
        # Existe el destino seleccionado
        #puts ":: paseDestinoGuardaTemporal() ::  (comboEstado != nil) ::"
        if (self.seleccionarDestino(comboEstado, destinoPase))
          return true
        end
      end
      return false
    end
    #
    def validarEstadoExpedienteParaPase(estadosValidos)
      indice = 0
      #estadoIniciacion = expedientePasesJSON['destinoEstados']['Iniciación']['Iniciación']
      #estadoActual = 'Tramitación' # [Iniciación, Tramitación, Subsanación] Pueden pasar a Tramitación. AGREGAR VALIDACIÓN DE ESTOS ESTADOS
      #estadosValidos = self.estadosValidosPaseTramitacion() # ['Iniciación', 'Tramitación', 'Subsanación'] # Estados válidos para la transición
      #destinoPase = 'Tramitación'
      existeEstado = false
      comboEstado = nil #
      #comboEstados = self.getBrowser().tds(:class => 'z-comboitem-text')
      comboEstadoActual = self.getBrowser().text_fields(:class => 'z-combobox-inp z-combobox-readonly')
      comboEstadoActual.each do |estado|
        #puts "Estado: #{indice} :  #{estado.value()} ::"
        indice = indice + 1
        #if ((estado.visible?) && ((estado.value() != nil) || (estado.value() != '')) && (estado.value() == estadoActual))
        if ((estado.visible?) && ((estado.value() != nil) || (estado.value() != '')) && (estadosValidos.include?(estado.value())))
          # Hay que ver como validar los acentos
          #puts ":: validarEstadoExpedienteParaPase(estadosValidos) ::Estado dentro de IF: #{indice} :  #{estado.value()} ::"
          existeEstado = true
          comboEstado = estado
          break
        end
      end
      if !(existeEstado)
        puts "validarEstadoExpedienteParaPase() - ERROR NO EXISTE EL ESTADO SELECCIONADO COMO DESTINO DE PASE."
        return nil
      end
      return comboEstado
    end
    #
    def seleccionarDestino(comboEstado, destinoPase)
      #puts ":: seleccionarDestino(destinoPase) :: #{destinoPase} ::"
      comboEstado.click()
      sleep 1
      estadoValido = self.validarDestinoSeleccionado(destinoPase)
      # Se selecciona el estado destino
      if (estadoValido != nil)
        estadoValido.click()
        return true
      end
      return false
      #
    end
    # Valida que el destino  exista para ser seleccionado
    def validarDestinoSeleccionado(destinoPase)
      indice = 0
      existeEstado = false
      estadoValido = nil
      comboEstadoActual = self.getBrowser().tds(:class => 'z-comboitem-text')
      comboEstadoActual.each do |estado|
        indice = indice + 1
        if ((estado.visible?) && ((estado.text() != nil) || (estado.text() != '')) && (estado.text() == destinoPase))
          existeEstado = true
          estadoValido = estado
          break
        end
      end
      if !(existeEstado)
        puts "validarDestinoSeleccionado(#{destinoPase}) - ERROR NO EXISTE EL ESTADO SELECCIONADO COMO DESTINO DE PASE."
        return nil
      end
      return estadoValido
    end
    #
    def seleccionarDestinoTramitacion(comboEstado)
      comboEstado.click()
      #
      indice = 0
      destinoPase = 'Tramitación'
      existeEstado = false
      estadoValido = nil
      comboEstadoActual = self.getBrowser().tds(:class => 'z-comboitem-text')
      comboEstadoActual.each do |estado|
        indice = indice + 1
        if ((estado.visible?) && ((estado.text() != nil) || (estado.text() != '')) && (estado.text() == destinoPase))
          existeEstado = true
          estadoValido = estado
          break
        end
      end
      if !(existeEstado)
        puts "seleccionarDestinoTramitacion(comboEstado) - ERROR NO EXISTE EL ESTADO SELECCIONADO COMO DESTINO DE PASE."
        return false
      end
      # Se selecciona el estado destino
      estadoValido.click()
      return true
      #
    end
    # NUEVA LÓGICA DE PASES CON CAMBIO DE ESTADO
    #
    # Estado destino: Inciación
    #
    def paseDestinoIniciacionDestinoUsuario(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoIniciacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    def paseDestinoIniciacionDestinoSector(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoIniciacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    # 
    def paseDestinoIniciacionDestinoMesaDeLaReparticion(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoIniciacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    # Estado destino: Tramitación
    #
    def paseDestinoTramitacionDestinoUsuario(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoTramitacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    def paseDestinoTramitacionDestinoSector(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoTramitacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    def paseDestinoTramitacionDestinoMesaDeLaReparticion(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoTramitacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    # Estado destino: Comunicación
    #
    def paseDestinoComunicacionDestinoUsuario(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoComunicacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    def paseDestinoComunicacionDestinoSector(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoComunicacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    def paseDestinoComunicacionDestinoMesaDeLaReparticion(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoComunicacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    # Estado destino: Ejecución
    #
    # # Pase a usuario con estado Ejecución
    def paseDestinoEjecucionDestinoUsuario(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoEjecucion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    # Pase a Sector de la repartición con estado Ejecución
    def paseDestinoEjecucionDestinoSector(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoEjecucion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    # Pase a Mesa de la repartición con estado Ejecución
    def paseDestinoEjecucionDestinoMesaDeLaReparticion(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoEjecucion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    # Estado destino: Subsanación
    #
    # Pase a usuario con estado subsanación
    def paseDestinoSubsanacionDestinoUsuario(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoUsuario()
      self.cargarDestinoUsuario()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoSubsanacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    # Pase a sector con estado subsanación
    def paseDestinoSubsanacionDestinoSector(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoSector()
      self.cargarDestinoSector()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoSubsanacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    # Pase a Mesa de la repartición con estado subsanación
    def paseDestinoSubsanacionDestinoMesaDeLaReparticion(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      self.seleccionarDestinoMesaDeLaReparticion()
      self.cargarDestinoMesaDeLaReparticion()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoSubsanacion())
        self.presionarRealizarPase()
      else
        return false
      end
      return true
    end
    #
    # Pase a Guarda Temporal
    def paseDestinoGuardaTemporalFinal(motivoPase)
      self.presionarRealizarPaseBotoneraTransversal()
      # Por los tiempos de carga del popup se realiza primero la selección de destino y luego se compelta el motivo de pase.
      sleep 1
      self.completarMotivoPase(motivoPase)
      if (self.paseDestinoGuardaTemporal())
        self.presionarRealizarPase()
        # Click en el cartel de aviso
        self.presionarBotonTD('Si','z-button-cm')
      else
        return false
      end
      return true
    end
    #

    # Luego evaluar la posibilidad de quietar estos métodos con hardcode por JSON
    def estadosValidosPaseInciacion()
      estadosValidos = ['Iniciación']
      return estadosValidos
    end
    #
    def estadosValidosPaseTramitacion()
      estadosValidos = ['Iniciación', 'Tramitación', 'Subsanación']
      return estadosValidos
    end
    #
    def estadosValidosPaseComunicacion()
      estadosValidos = ['Tramitación', 'Comunicación']
      return estadosValidos
    end
    #
    def estadosValidosPaseEjecucion()
      estadosValidos = ['Comunicación', 'Ejecución']
      return estadosValidos
    end
    #
    def estadosValidosPaseSubsanacion()
      estadosValidos = ['Iniciación', 'Tramitación', 'Ejecución' , 'Subsanación']
      return estadosValidos
    end
    #
    def estadosValidosPaseGuardaTemporal()
      estadosValidos = ['Iniciación', 'Tramitación', 'Comunicación' , 'Ejecución' , 'Subsanación']
      return estadosValidos
    end
  end
###############################################################################