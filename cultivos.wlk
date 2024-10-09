import wollok.game.*
import hector.*
import granja.*

class Maiz {
    var estado = baby
    var position = null

    method position() {return position}
	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "corn_" + estado + ".png"
	}

    method sembrar(parcela){
        position = parcela
    }

//CRECER (REGAR)
    method crecer() {
        estado = adult
    }


//COSECHAR
    method cosechar(){
        self.validarCosecharse()
        game.removeVisual(self)
        granja.cosechar(self)
    }

    method validarCosecharse(){
        if(!estado.puedeCosecharse()){
            self.error("No puedo ser cosechado")
        }
    }

//VENDER
    method valor(){
        return 150
    }






//SOLO PARA PODER HACER LOS TEST 
    method estado(){
        return estado
    }
}

//ESTADOS MAIZ

object baby{
    method puedeCosecharse(){
        return false
    }
}
object adult {
    method puedeCosecharse(){
        return true
    }


}

//TRIGO
class Trigo{
    var estado = 0

    var position = null

    method position() {return position}
    method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "wheat_" + estado + ".png"
	}

    method sembrar(parcela){
        position = parcela
    }


//CRECER (REGAR)
    method crecer(){
        estado = (estado + 1) % 4
    }


//COSECHAR
    method cosechar(){
        self.puedeCosecharse()
        granja.cosechar(self)
        game.removeVisual(self)
    }

    method puedeCosecharse(){
        if(estado < 2){
            self.error("No se puede cosechar")
        }
    }

//VENDER
    method valor(){
        return (estado - 1) * 100
    }



//SOLO PARA PODER HACER LOS TEST 
    method estado(){
        return estado
    }
   
}

object uno{
    method puedeCosecharse() {
        return false
    }
}


//TOMACO
class Tomaco {

    var position = null
    method position() {return position}
    var estado = tomaco


    method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return estado.toString() + ".png"
	}

    method sembrar(parcela){
        position = parcela
    }
//CRECER (REGAR)
    method crecer(){
        self.validarCrecer()
        position = position.up(1)
    }

    method validarCrecer() {
        if(!self.puedeCrecer() || self.hayObjetoEn(position.up(1))){
            self.error(null)
        }
    }

    method hayObjetoEn(parcela){
        return !game.getObjectsIn(parcela).isEmpty()
    }

    method puedeCrecer() {
        return position.y() <= game.height() - 2
    }

//COSECHAR
    method cosechar(){
        game.removeVisual(self)
        granja.cosechar(self)
    }

//VENDER
    method valor(){
        return 80
    }

}

object tomaco {
    method puedeCosechar(){
        return true
    }
}