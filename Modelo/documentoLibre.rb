# Clase que se utiliza para dar de alta un nuevo documento GEDO del tipo libre#
  require 'watir-webdriver'
  require '../constantes.rb'
  require './documento.rb'

  class DocumentoLibre < Documento
    attr_accessor
      :textoLibre
    # Getters
    def getTextoLibre
      return @textoLibre
    end
    # Setters
    def setTextoLibre(textoLibre)
      @textoLibre = textoLibre
    end
    # Cada tipo de documento deberá implementar su manera de parsear    
    def parseJSON()
      archivoDatosGEDO = open("../JSON/documentoLibre.json")
      datosGEDO = archivoDatosGEDO.read
      datosGEDOParseo = JSON.parse(datosGEDO)
      self.setTextoLibre(datosGEDOParseo["documentoGEDO"]["textoLibre"])
      self.parseJSONGenerico(datosGEDOParseo)
      #self.setAcronimo(datosGEDOParseo["documentoGEDO"]["acronimo"])
      #self.setReferencia(datosGEDOParseo["documentoGEDO"]["referencia"])
      #datosGEDOParseo = super.parseJSON()      
    end
    #def producirDocumento(referencia, textoLibre)
    def producirDocumento()
      #Cada documento debe implementar su manera de confeccionar
      self.completarReferenciaLibre(self.getReferencia())
      self.completarTextoLibre(self.getTextoLibre())
      self.parsearBotonesProducirDocumento()
    end
    def completarReferenciaLibre(referencia)
      # Se aguarda que cargue correctamente la pantalla de Producir documento
      self.getBrowser().text_field(:class => 'z-bandbox-inp').wait_while_present
      # Se completa la referencia
      # Obtener todos los inputs text y filtar los que no son visible
      # Completa todos los campos que existen
      #indice = 0
      cajasDeTexto = self.getBrowser().text_fields(:class => 'z-textbox')
      cajasDeTexto.each do |cajaDeTexto|
        if cajaDeTexto.visible?
          cajaDeTexto.set referencia
          cajaDeTexto.fire_event :blur
          #log.info("Lugar campo referencia: #{indice}")
          break
        end
        #indice = indice + 1
      end
    end
    def completarTextoLibre(textoLibre)
      # Completar el texto libre del documento GEDO
      self.getBrowser().execute_script("$($('iframe').get(1)).contents().find('body').append('<p>#{textoLibre}</p>')")
    end
  end
###############################################################################