class Mision {
  method puedeCompletarMision(unBarco) = unBarco.tieneSuficienteTripulacion()
}

class BusquedaDelTesoro inherits Mision {
  method tieneItemsDelTesoro(unPirata) {
    return 
    unPirata.items().contains("brujula") || 
    unPirata.items().contains("mapa") ||  
    unPirata.items().contains("botellaGrog") 
  }  

  method esUtil(unPirata) = self.tieneItemsDelTesoro(unPirata) && unPirata.monedas() <= 5

  override method puedeCompletarMision(unBarco) = super(unBarco) && unBarco.tripulanteTieneObjeto("llaveDeCofre") 
}

class Leyenda inherits Mision{
  const itemObligatorio

  method esUtil(unPirata) = unPirata.items().size() >= 10 && unPirata.items().contains(itemObligatorio)
}

class Saqueo inherits Mision{
  const objetivo 

  method esUtil(unPirata) = unPirata.monedas() < cantidadMonedas.cantidad() && objetivo.puedeSerSaqueadoPor(unPirata)

  override method puedeCompletarMision(unBarco) = super(unBarco) && objetivo.esVulnerableA(unBarco)
}

object cantidadMonedas {
  var property cantidad = 10 
}