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
