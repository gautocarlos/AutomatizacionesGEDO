# Clase que se utiliza para dar de alta un nuevo documento GEDO del tipo libre#
  require 'watir-webdriver'
  require '../constantes.rb'
  require './documento.rb'

  class DocumentoImportadoTemplate < Documento
    # Cada tipo de documento deberá implementar su manera de parsear    
    def parseJSON()
      archivoDatosGEDO = open("../JSON/documentoImportadoTemplate.json")
      datosGEDO = archivoDatosGEDO.read
      datosGEDOParseo = JSON.parse(datosGEDO)
      #self.setAcronimo(datosGEDOParseo["documentoGEDO"]["acronimo"])
      #self.setReferencia(datosGEDOParseo["documentoGEDO"]["referencia"])
      #self.setFFCC(datosGEDOParseo["documentoGEDO"]["ffcc"])
      self.parseJSONGenerico(datosGEDOParseo)
      self.parseJSONIMPORTADO(datosGEDOParseo)
      self.parseJSONFFCC(datosGEDOParseo)
    end
    # Producción de documento Template
    def producirDocumento()
      # Cada documento debe implementar su manera de confeccionar
      self.completarReferencia(self.getReferencia())
      # Importa un archivo
      self.importarArchivo()
      self.completarFFCC()
      self.parsearBotonesProducirDocumento()
    end
  end
###############################################################################