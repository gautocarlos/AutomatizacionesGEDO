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
    # Setters
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
    # Métodos
    def parseJSON
      archivoDatosEE = open("../JSON/expediente.json")
      datosEE = archivoDatosEE.read
      datosEEParseo = JSON.parse(datosEE)
      self.setTrata(datosEEParseo["expediente"]["trata"])
      self.setMotivoInterno(datosEEParseo["expediente"]["motivoInterno"])
      self.setMotivoExterno(datosEEParseo["expediente"]["motivoExterno"])
      self.setDescAdicional(datosEEParseo["expediente"]["descAdicional"])
    end
    # Realiza una caratulación interna de expediente
    def caratularInterno()
      self.getBrowser().divs(:class => 'z-toolbarbutton-cnt')[1].click
      Watir::Wait.until { self.getBrowser().text_fields(:class => 'z-textbox')[0].exists?}
      self.getBrowser().text_fields(:class => 'z-textbox')[0].set self.getMotivoInterno()
      self.getBrowser().text_fields(:class => 'z-textbox')[1].set self.getMotivoExterno()
      self.getBrowser().text_fields(:class => 'z-textbox')[2].set self.getDescAdicional()
      self.getBrowser().text_field(:class => 'z-bandbox-inp').set self.getTrata()
      # Selecciona la trata
      self.getBrowser().element(:class => 'z-modal-mask').click
      self.getBrowser().execute_script("($('.z-toolbarbutton').get(3)).click()")
      Watir::Wait.until { self.getBrowser().element(:class => 'z-button-cm').exists?}
      self.getBrowser().element(:class => 'z-button-cm').click
    end
    # Realiza una caratulación interna de expediente
    def caratularExterno()
      self.getBrowser().divs(:class => 'z-toolbarbutton-cnt')[2].click
      Watir::Wait.until { self.getBrowser().text_fields(:class => 'z-textbox')[0].exists?}
      self.getBrowser().text_fields(:class => 'z-textbox')[0].set self.getMotivoInterno()
      self.getBrowser().text_fields(:class => 'z-textbox')[1].set self.getMotivoExterno()
      self.getBrowser().text_fields(:class => 'z-textbox')[2].set self.getDescAdicional()
      self.getBrowser().text_field(:class => 'z-bandbox-inp').set self.getTrata()
      # Selecciona la trata
      self.getBrowser().element(:class => 'z-modal-mask').click
      self.getBrowser().execute_script("($('.z-toolbarbutton').get(3)).click()")
      Watir::Wait.until { self.getBrowser().element(:class => 'z-button-cm').exists?}
      self.getBrowser().element(:class => 'z-button-cm').click
    end
  end
###############################################################################