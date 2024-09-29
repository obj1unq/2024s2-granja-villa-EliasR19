import wollok.game.*
import cultivos.*
import granja.*

object hector {
    var oro = 0
    const cosechado = []
	var property position = game.center()
	const property image = "player.png"

    method mover(direccion) {
        position = direccion.siguiente(position)
    }

    //SEMBRAR
    method sembrar(semilla){
        self.validarSembrar()
        granja.cultivar(semilla)
        game.addVisual(semilla)
    }

    method validarSembrar(){
        if(granja.hayCultivoEn(position.x(), position.y())){
            self.error("Ya esta ocupado")
        }
    }

    //REGAR
    method regarAhi() {
        self.validarRegar()
        const cultivo = game.uniqueCollider(self)
       cultivo.crecer()
    }

    method validarRegar(){
        if(!granja.hayCultivoEn(position.x(), position.y())){
            self.error("No hay planta que regar")
        }
    }

    //COSECHAR
    method cosecharAhi(){
        self.validarCosechar()
        const cultivo = game.uniqueCollider(self)
        cosechado.add(cultivo)
        cultivo.cosechar()
    }

    method validarCosechar() {
         if(!granja.hayCultivoEn(position.x(), position.y())){
            self.error("No tengo nada para cosechar")
        }
    }

//VENDER
    method vender() {
        oro = cosechado.sum( {cultivo => cultivo.valor()})
        cosechado.clear()
    }


    method contar(){
        return game.say(self, "tengo" + oro + " monedas y" + cosechado.size() + " plantas para vender")
    }
}



