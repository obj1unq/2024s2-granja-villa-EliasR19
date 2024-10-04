import wollok.game.*
import hector.*
import granja.*

class Maiz {
    var estado = "baby"

	var property position = hector.position()

	method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "corn_" + estado + ".png"
	}

//CRECER (REGAR)
    method crecer() {
        estado = "adult"
    }


//COSECHAR
    method cosechar(){
        self.puedeCosecharse()
        game.removeVisual(self)
        granja.cosechar(self)
    }

    method puedeCosecharse(){
        if(estado == "baby"){
            self.error(null)
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

class Trigo{
    var estado = 0

    var property position = hector.position()
    method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "wheat_" + estado.toString() + ".png"
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

class Tomaco {

    var property position = hector.position()
    method image() {
		// TODO: hacer que devuelva la imagen que corresponde
		return "tomaco.png"
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
