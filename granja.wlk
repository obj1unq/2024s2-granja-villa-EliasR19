import hector.*
import cultivos.*

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
    method hayCultivoEn(positionX, positionY){
        return cultivos.any( { cultivo => cultivo.position().x() == positionX && cultivo.position().y() == positionY })
    }

    // Los cultivos se van cuando hector los cosecha.
    method cosechar(cultivo) {
        cultivos.remove(cultivo)
    }
}
