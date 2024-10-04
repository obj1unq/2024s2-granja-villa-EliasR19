import hector.*
import cultivos.*
import wollok.game.*
import movimiento.*

// Granja
object granja {
    const cultivos = []

    method cultivar(cultivo){
        cultivos.add(cultivo)
    }

    // Se conocen los cultivos.
    method cultivos() {
        return cultivos
    }

    
    // Se conoce si hay algun cultuvo en X,Y posicion.
    method hayCultivoEn(parcela){
        return cultivos.any( { cultivo => cultivo.position().x() == parcela.x() && cultivo.position().y() == parcela.y() })
    }

    // Los cultivos se van cuando hector los cosecha.
    method cosechar(cultivo) {
        cultivos.remove(cultivo)
    }

    //TEST
}


//ASPERSORES
class Aspersor {

    const parcelasARegar = [    game.at(position.x() , position.y()+1),     // N
                                game.at(position.x()+1, position.y()+1),    //N-E
                                game.at(position.x()+1, position.y()),      //E
                                game.at(position.x()+1, position.y()- 1),   //S-E
                                game.at(position.x(), position.y()-1),      //S    
                                game.at(position.x()-1, position.y()-1),    //S-O
                                game.at(position.x()-1, position.y()),      //O
                                game.at(position.x()-1, position.y()+1)     //N-O
                            ]   

                     
    

    var property position = hector.position() 
    method image() = "aspersor.png"

    method iniciarRiego() {
        game.onTick(5000, "aspersorRiega", {self.regarAlrededor() }) //En 1 segundo es muy rapido, y algunos no crecen porque se bugea o algo
    }

    method regarAlrededor(){
        parcelasARegar.forEach({parcela => self.regarCultivoEn(parcela)})
    }
    
    method regarCultivoEn(parcela){                             //agregarle el parametro cultivo para hacer test
        self.validarRegarEn(parcela)
        const cultivo = game.getObjectsIn(parcela).last()     //comentar para test
        cultivo.crecer()
    }

    method validarRegarEn(parcela){
        if(!granja.hayCultivoEn(parcela)){
            self.error("null")
        }
    }

    method crecer() {} //polimorfismo
    method cosechar() {}
    method vender() {}
}
