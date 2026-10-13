
class PackDeViaje {
    const duracion
    method duracion() = duracion 
    const precioBase
    const coordinadorACargo
    method coordinadorACargo() = coordinadorACargo
    const beneficios = ["Translado Privado","Acceso Vip", "Seguro Adicional"]
    method estaVigente() = estaVigente
    var estaVigente = true
    method esPackPremium()
    method alternarVigencia() {
        estaVigente = !estaVigente
    }

    method valorFinal() {
        return precioBase + self.costoBeneficiosVigentes()
    }

    method costoBeneficiosVigentes() {
        return self.beneficiosVigentes().sum({ beneficio => beneficio.costo() })
    }

    method beneficiosVigentes() {
        return beneficios.filter({ beneficio => beneficio.estaVigente() })
    }
}
class PackNacional inherits PackDeViaje{
    const provinciaDestino
    method provinciaDestino() = provinciaDestino
    const actividadesIncluidas = [" "]
    override method esPackPremium() {
        return coordinadorACargo.cantidadViajesRealizados() > 10 and 
        duracion > 20 and 
        coordinadorACargo.esAltamenteCalificado()
    }
}


class PackInternacional inherits PackDeViaje{
    method provinciaDestino()
    const escalas
    method escalas() = escalas

    method esLugarDeInteres() 
    override method valorFinal() {
      return super()*1.2
    }
    override method esPackPremium() {
        return self.esLugarDeInteres() and (duracion > 20) and
        (escalas == 0 )
    }
}

class Coordinador {
    const cantidadViajesRealizados
    method cantidadViajesRealizados() = cantidadViajesRealizados 
    const aniosDeExp
    method aniosDeExp() = aniosDeExp
    var rol
    method rol() = rol 
    
    method cantidadSuficienteDeViajes() = cantidadViajesRealizados > 20
    method esAltamenteCalificado() {
        return (self.cantidadSuficienteDeViajes()) and rol.cumpleCondicion(self)
    }
    const rolesValidos = ["guia", "asistenteLog", "acompañante"]

    method estaMotivado()

    method cambiarDeRol(nuevoRol) {
        if (not rolesValidos.contains(nuevoRol)) {
            self.error("Rol incorrecto: " + nuevoRol)
        }
        rol = nuevoRol
    }
}


//Condiciones para ser altamente calificado
object guia {
    method cumpleCondicion(coordinador) = coordinador.estaMotivado()
}

object asistenteLog {
    method cumpleCondicion(coordinador) = coordinador.aniosDeExp() >= 3
}

object acompañante {
    method cumpleCondicion(coordinador) = true
}

