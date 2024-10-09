import wollok.game.*
import hector.*
import cultivos.*
import granja.*

class Mercado{
    var property position
    method image() { return "market.png"}

    var property monedas 
    const property mercaderia = [] // property para los test

    method comprarCosas(cosas){
        self.validarComprar(cosas)
        mercaderia.addAll(cosas)
        monedas = monedas - self.valorTotalDe(cosas)
    }

    method validarComprar(cosas){
        if(!self.tieneMonedasParaComprar(cosas)){
            self.error("No tengo suficiente dinero")
        }
    }

    method tieneMonedasParaComprar(cosas){
        return monedas >= self.valorTotalDe(cosas)
    }

    method valorTotalDe(cosas){
        return cosas.sum({cosa => cosa.valor()})
    }

    method consechar(){} // polimorfismo

}

object mercados {
    const property mercadoA = new Mercado(position = game.at(1,1), monedas = 1000)
    const property mercadoB = new Mercado(position = game.at(7,8), monedas = 233)
    const property mercadoC = new Mercado(position = game.at(8,1), monedas = 80)

    method iniciar(){
        game.addVisual(mercadoA)
        game.addVisual(mercadoB)
        game.addVisual(mercadoC)
        }
}