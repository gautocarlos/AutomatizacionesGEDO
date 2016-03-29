# Clase para realizar el login a la aplicación ##############################
  # Clase 
  require 'json'
  class Login
   # constructor
    #def initialize(urlModulo, usuario, password)
    def initialize()
      #@urlModulo = urlModulo
      #@usuario = usuario
      #@password = password
      self.parseJSON()
    end
    # Levanta los datos de login desde un JSON
    def parseJSON
      archivoDatosLogin = open("../JSON/usuarioSade.json")
      datosLogin = archivoDatosLogin.read
      datosLoginParseo = JSON.parse(datosLogin)
      self.setUrlModulo(datosLoginParseo["login"]["url"]["urlModulo"])
      self.setUsuario(datosLoginParseo["login"]["usuario"]["nombreUsuario"])
      self.setPassword(datosLoginParseo["login"]["usuario"]["password"])
    end
    # Getters
    def getUrlModulo
      @urlModulo
    end
    def getUsuario
      @usuario
    end
    def getPassword
      @password
    end
    # Setters
    def setUrlModulo(urlModulo)
      @urlModulo = urlModulo
    end
    def setUsuario(usuario)
      @usuario = usuario
    end
    def setPassword(password)
      @password = password
    end
    # Métodos
    # Ingresar al módulo
    def ingresar
      browser = Watir::Browser.new
      browser.goto getUrlModulo()
      Watir::Wait.until { browser.text_field(:id => 'username').exists?}
      #log.info("Inicio Login CAS")  
      # Inicio Login CAS  
      browser.text_field(:id => 'username').set getUsuario()
      browser.text_field(:id => 'password').set getPassword()
      browser.button(:name => 'submit').click
      return browser
    end
  end
#############################################################################