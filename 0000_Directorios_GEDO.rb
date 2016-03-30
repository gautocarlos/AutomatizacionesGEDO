#############################################################
  #Crear una carpeta por día y hora de logs
  if !Dir.exists?(GEDORUTALOGS)
    Dir.mkdir(GEDORUTALOGS)
  end
  
  #Crear una carpeta por día y hora de Screenshots
  if !Dir.exists?(GEDORUTASCREENSHOT)
    Dir.mkdir(GEDORUTASCREENSHOT)
  end
  #############################################################