import wollok.game.*
import cultivos.*
import granja.*
import mercados.*

object hector {
    var monedas = 0
    var cosechado = []  //sería const, pero lo dejo en var para los tests
    const property aspersores = []

    



    var property position = game.center()
	const property image = "player.png"

    method mover(direccion) {
        position = direccion.siguiente(position)
    }

    //SEMBRAR
    method sembrar(semilla){
        self.validarSembrar()
        semilla.sembrar(self.position())
        granja.cultivar(semilla)
        game.addVisual(semilla)
    }

    method validarSembrar(){
        if(self.hayAlgoEn(position)){ //position.x(), position.y())){
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
        if(!self.hayAlgoEn(position)){
            self.error("No hay planta que regar")
        }
    }

    //COSECHAR
    method cosecharAhi(){
        self.validarCosechar()
        const cultivo = game.uniqueCollider(self)
        cultivo.cosechar()

        cosechado.add(cultivo)
        granja.cosechar(cultivo)
    }


    method validarCosechar() {
         if(!self.hayAlgoEn(position) ){
            self.error("No tengo nada para cosechar")
        }
    }

//VENDER
    method venderTodo() {
        self.validarVender()
        const mercado = game.uniqueCollider(self)  // Se comenta para los test
        mercado.comprarCosas(self.cosechado())      //Se comenta para los test
        monedas = monedas + cosechado.sum( {cultivo => cultivo.valor()})
        cosechado.clear()
    }

    method contar(){
        return game.say(self, "tengo " + monedas + " monedas y " + cosechado.size() + " plantas para vender")
    }

    method validarVender() {
        if(!granja.hayMercadoAca(position)){
            self.error("No estoy en un mercado")
        }
    }


//ASPERSORES

    method ponerAspersorAhi(){  // Se pone con la Z porque con la A camina.
        self.validarPonerAspersor()
        aspersores.add(new Aspersor())  //Modelado en granja
        game.addVisual(aspersores.last())
        aspersores.last().iniciarRiego()

    }
    method validarPonerAspersor() {
         if(self.hayAlgoEn(position)){
            self.error("Ya esta ocupado")
        }
    }


    //VALIDACIONES
    method hayAlgoEn(parcela){
        return granja.hayCultivoEn(parcela) || self.hayAsperorEn(parcela) || granja.hayMercadoAca(parcela)
    }



    method hayAsperorEn(parcela){
        return aspersores.any({aspersor => aspersor.position().x() == parcela.x() && aspersor.position().y() == parcela.y()})
    }


    method crecer(){} //polimorfismo



//SOLO PARA LOS TEST
    method cosechado(listaCultivos){
        cosechado = listaCultivos
    }
    method cosechado() {
        return cosechado
    }
    method monedas() {
        return monedas
    }
}





