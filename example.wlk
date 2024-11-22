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
  
  method vivirEvento(evento) = emociones.forEach({emocion=>emocion.liberar(evento)})
  
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
  /*
  tiene una serie de palabrotas se se aprenden y olvidan 

  puede liberarse si tiene intensidad elevada y si conoce al menos un apalabrota con mas de 7 letras
  su intensidad inicial es de 100 pero puede variar 

  cuando se libera disminuirintensidad en impacto . y olvida la primer palabrota
  */

  const palabrotas=[]

  method aprenderPalabrota(palabra)=palabrotas.add(palabra)

  method olvidarPalabrota()=palabrotas.remove(palabrotas.get(0))

  

  method puedeLiberarse(evento)=self.intencidadElevada() &&  palabrotas.any{palabra=>palabra.size()>7}
 

  method liberar(evento) {
    if(self.puedeLiberarse(evento) && self.esEventoLiberador(evento)) {
      intensidad -= evento.impacto()//Revisar descuento de intensidad
      self.olvidarPalabrota()
      experimentaron+=1
    }
  }
  
 

  
}
object alegria inherits Emocion(eventosVividos=[ganarPremio],intensidadMax=400){
  //le mpaso evento y disminuye intensidad
  //No pude tener intensidad negativo (mismo valor pero positivo)
  // es liberada con intensidad elevada y cantidad de eventos vividos par 


 
  method liberar(evento) {
    if(self.puedeLiberarse(evento)){
    intensidad-=evento.impacto()
    intensidad.abs()
    experimentaron+=1}
    
  }

  method puedeLiberarse(evento)= self.intencidadElevada() && self.eventosVividos().size().even() && self.esEventoLiberador(evento)
     
   
  }
  
  




object tristeza inherits Emocion(eventosVividos=[desaprobarParcial],intensidadMax=250){
  /*
  intensidad sin limiacion
  puede liberarse con melancolia  o otro evento y su intensidad elevada
  disminuir la intensidad en unidades de impacto
  se registra la descripcion del evento
  */

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
   /*
  Intensidad elevada y cantidad de eventos es mayor que intensidad
  liberar implica disminuir la intensida en impacto
  */
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

object grupo {
  var property itegrantes = [juan,pedro,manuel] 
}
