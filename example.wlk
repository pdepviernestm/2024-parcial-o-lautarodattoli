class Persona{
  const property edad 
  var property eventos=[]
  var property emociones=[]

  method esAdolescente()=edad.min(12).max(18)

  method agregarEmocion(emocion) = emociones.add(emocion)
  method eliminarEmocion(emocion)=emociones.remove(emocion)
  method agregarEventos(evento) = eventos.add(evento)
  method eliminarEvento(evento)=emociones.remove(evento)
  
  method explotaEmocionalmente()=emociones.all{emocion=>emocion.puedeLiberarse(eventos.any())}
  
  method vivirEvento(evento) = emociones.map({emocion=>emocion.liberar(evento)})
  
}

class Evento{
  const property descripcion=[]
  var property impacto

}

//Eventos
const melancolia=new Evento(
  descripcion="decaido por sucesos de la vida",impacto=40
  )

const resfriado=new Evento(
  descripcion="decaido por falta de fuerza",impacto=10
  )

const ganarPremio=new Evento(
  descripcion="Demostracion de esfuerzo",impacto=50
  )

const discutir=new Evento(
  descripcion="genera trizteza ",impacto=10
  )

const oscuridad=new Evento(
  descripcion="genera panico en la gente ",impacto=20
  )

const desaprobarParcial=new Evento(
  descripcion="genera panico en la gente ",impacto=20
  )


class Emocion{
  var property intensidadMax=200
  var property intensidad =20 
  const property eventosVividos=[]
  method intencidadElevada()=self.intensidad() >100
  method esEventoLiberador(evento)=eventosVividos.contains(evento)
  var property experimentaron =0

}




//Emociones
object furia inherits Emocion (intensidad=100,eventosVividos=[discutir,resfriado]){
 

  const palabrotas=[]

  method aprenderPalabrota(palabra)=palabrotas.add(palabra)

  method olvidarPalabrota()=palabrotas.remove(palabrotas.get(0))

  

  method puedeLiberarse(evento)=self.intencidadElevada() &&  palabrotas.any{palabra=>palabra.size()>7}
 

  method liberar(evento) {
    if(self.puedeLiberarse(evento) && self.esEventoLiberador(evento)) {
      intensidad -= evento.impacto()
      self.olvidarPalabrota()
      experimentaron+=1
    }
  }
  
 

  
}
object alegria inherits Emocion(eventosVividos=[ganarPremio],intensidadMax=400){
 
  method liberar(evento) {
    if(self.puedeLiberarse(evento)){
    intensidad-=evento.impacto()
    intensidad.abs()
    experimentaron+=1}
    
  }

  method puedeLiberarse(evento)= self.intencidadElevada() && self.eventosVividos().size().even() && self.esEventoLiberador(evento)
     
   
  }
  
  




object tristeza inherits Emocion(eventosVividos=[desaprobarParcial],intensidadMax=250){

  var causa=[]
  method liberar(evento) { 
    if(self.puedeLiberarse(evento)){
    causa=evento.descripcion()
    intensidad-=evento.intensidad()
    experimentaron+=1
  }
  }

  method puedeLiberarse(evento)=eventosVividos.contains(melancolia) || (self.esEventoLiberador(evento) && self.intencidadElevada())
  
  

  
  
}
class DesagradoTemor inherits Emocion{
  
  method liberar(evento) {
   if(self.puedeLiberarse(evento)){
    intensidad-=evento.intensidad()
    experimentaron+=1}
  }

  method puedeLiberarse(evento)=self.esEventoLiberador(evento) || self.intencidadElevada() && eventosVividos.size()>intensidad
     
    
  
  

}
object desagrado inherits DesagradoTemor(eventosVividos=[resfriado]){}
object temor inherits DesagradoTemor(eventosVividos=[oscuridad]){}

const juan =new Persona (edad=17) 
const pedro =new Persona(edad=15)
const manuel =new Persona(edad=12)

class Grupo {
  var property integrantes = [juan,pedro,manuel] 
  
  method aplicarEvento(evento) {
    integrantes.all{integrante=>integrante.aplicarEvento(evento)}
  }
  }

// **** INTENSAMENTE 2 **********

object ansiedad inherits Emocion(
  intensidad=500,intensidadMax=1000,
  eventosVividos=[ganarPremio,resfriado,discutir,desaprobarParcial,melancolia]) {
   
   var indice=1

   method liberar(evento) {
   if(self.puedeLiberarse(evento)){
    intensidad-=(evento.intensidad() * indice)
    indice +=1
    experimentaron+=1}
  }

  method puedeLiberarse(evento)=self.esEventoLiberador(evento) || (self.intencidadElevada()&& self.eventosVividos().size()>3)
  //Por cada evento que lo libera aumenta el indice y por lo tanto modifica de forma màs abrupta a la intensidad
}


/*
Los conceptos de polimorfismo nos fueron utiles para que caba objeto de una misma clase
entienda los mismos mensajes y asi hacer el codigo màs funcional ya que es generico,al agregar otro elemento con 
otros atributos pero que respete el polimirfismo no se cambiaria el codigo. 
Y en el caso de herencia me aseguro que los objetos que tengan los mismos datos esten vinculados
a una clase de la cual heredan estos atributos y pueden tener otros independientes de resto de los de la clase.


*/
