class CiudadCostera {
  var property habitantes

  method agregarHabitante(unHabitante) {
    habitantes.add(unHabitante)
  }

  method esVulnerableA(unBarco) = unBarco.cantidadTripulantes() >= habitantes * 0.4 || unBarco.estanTodosPasadosDeGrog()

  method puedeSerSaqueadoPor(unPirata) = unPirata.nivelEbriedad() >= 50
}