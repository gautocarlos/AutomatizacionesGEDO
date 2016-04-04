  # Alta de documento GEDO
  #############################################################
  require 'watir-webdriver'
  require 'logger'
  #Levantar las constantes declaradas
  require '../constantes.rb'
  # Genera los dorectorios de logs
  require '../0000_Directorios_GEDO.rb'
  require './login.rb'
  # Clases de expediente
  require './expediente.rb'

  #Recibe por parámetro la ruta del archivo de configuración y el módulo al cual ingresar
  login = Login.new("C:/Users/cargauto/Documents/GitHub/AutomatizacionesGEDO/json/configuraciones.json","EE")
  login.ingresar()
  browser = login.getBrowser()

  expediente = Expediente.new(browser)
  #expediente.caratularInterno()
  ##########
  expediente.consultaExpedientesPorNumeroSADE("2016", "00086369", "CHARLY")
  expediente.tramitarEjecutarTarea()
  ##########
  expediente.tramitarAdquirirTarea()

  imagenes = browser.images
  imagenes.each do |imagen|
    if imagen.title == "Ver expediente"
      imagen.click
    end
  end

      botonera = browser.spans(:class => 'z-label') 
      botonera.each do |boton|
        if (boton.title == "Tramitar Expediente")
          boton.click
        end
      end

      botonera = self.getBrowser().lis(:class => 'z-menu-item')
      botonera.each do |boton|
        if (boton.title == "Tramitar Expediente")
          boton.click
        end
      end

      browser.lis(:class => 'z-menu-item')[8].click



  browser.spans(:class => 'z-tab-text').find(browser.span(:class => 'z-tab-text').text == "Consultas")
  browser.spans(:class => 'z-button')[1].click()

  botonera = browser.spans(:class => 'z-tab-text') 
  botonera.each do |boton|
    if (boton.text == "Consultas")
      boton.click
    end
  end

  #############################################################