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
  ##########

  browser.spans(:class => 'z-tab-text').find(browser.span(:class => 'z-tab-text').text == "Consultas")
  browser.spans(:class => 'z-button')[1].click()

  botonera = browser.spans(:class => 'z-tab-text') 
  botonera.each do |boton|
    if (boton.text == "Consultas")
      boton.click
    end
  end

  #############################################################