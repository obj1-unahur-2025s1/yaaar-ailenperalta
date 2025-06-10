class BarcoPirata {
  var mision 
  const property tripulacion = []
  const capacidad 

  method agregarTripulante(unPirata) {
    if (self.tieneLugar() && mision.esUtil(unPirata)) {
      tripulacion.add(unPirata)
    }
  }

  method sacarTripulante(unPirata) {
    tripulacion.remove(unPirata)
  }

  method tieneLugar() = tripulacion.size() < capacidad 

  method cantidadTripulantes() = tripulacion.size()

  method tieneSuficienteTripulacion() = tripulacion.size() * 0.9 >= capacidad

  method tripulanteTieneObjeto(unObjeto) = tripulacion.any({t => t.items().contains(unObjeto)})

  method esVulnerableA(unBarco) = unBarco.cantidadTripulantes() / 2 >= self.cantidadTripulantes() 

  method puedeSerSaqueadoPor(unPirata) = unPirata.estaPasadoDeGrog()

  method estanTodosPasadosDeGrog() = tripulacion.all({t => t.estaPasadoDeGrog()})

  method cambiarMision(nuevaMision) {
    mision = nuevaMision
    tripulacion.removeAll(self.tripulantesQueNoSirvenPara(nuevaMision))
  } 

  method tripulantesQueNoSirvenPara(unaMision) = tripulacion.filter({t => !unaMision.esUtil(t)})

  method anclarEnCiudad(unaCiudad) {
    tripulacion.forEach({t => t.tomarTragoDeGrog()})
    self.sacarTripulante(self.tripulanteMasEbrio())
    unaCiudad.agregarHabitante(self.tripulanteMasEbrio())
  }

  method tripulanteMasEbrio() = tripulacion.max({p => p.nivelEbriedad()})

  method esBarcoTemible() = mision.puedeCompletarMision(self)

  method tripulantesPasadosDeGrog() = tripulacion.filter({p => p.estaPasadoDeGrog()})

  method cantTripulantesPasadosDeGrog() = tripulacion.count(self.tripulantesPasadosDeGrog())

  method cantItemsDistintos() {}

  method tripulantePasadoDeGrogConMasMonedas() = self.tripulantesPasadosDeGrog().max({p => p.monedas()})
  
  method tripulanteQueMasPiratasInvito() {}
}

class CiudadCostera {
  var property habitantes

  method agregarHabitante(unHabitante) {
    habitantes.add(unHabitante)
  }

  method esVulnerableA(unBarco) = unBarco.cantidadTripulantes() >= habitantes * 0.4 || unBarco.estanTodosPasadosDeGrog()

  method puedeSerSaqueadoPor(unPirata) = unPirata.nivelEbriedad() >= 50
}

class Pirata {
  var nivelEbriedad 
  var monedas
  const property items = [] 
  const quienLoInvito 

  method nivelEbriedad() = nivelEbriedad

  method monedas() = monedas 

  method esUtilPara(unaMision) = unaMision.esUtil(self) 

  method estaPasadoDeGrog() = nivelEbriedad >= 90

  method tomarTragoDeGrog() {
    nivelEbriedad += 5
    monedas = (monedas - 1).max(0)
  }
}

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



