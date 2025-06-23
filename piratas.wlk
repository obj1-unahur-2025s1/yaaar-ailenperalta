class Pirata {
  var nivelEbriedad 
  var monedas
  const property items = [] 

  method nivelEbriedad() = nivelEbriedad

  method monedas() = monedas 

  method esUtilPara(unaMision) = unaMision.esUtil(self) 

  method estaPasadoDeGrog() = nivelEbriedad >= 90

  method tomarTragoDeGrog() {
    nivelEbriedad += 5
    monedas = (monedas - 1).max(0)
  }
}