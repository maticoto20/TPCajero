class Persona{
	var property pin = 0
	var property sueldo = 0
//	constructor(_pin){
//		pin = _pin
//	}
}

object cajero{
	var cuentas = []
	method pinValido(pin){
		return true
	}
	method pinCorrecto(persona, pin){
		return pin.equals(persona.pin())
	}
	method cambiarPin(persona, pin){
		if (!self.pinValido(pin)){
			throw new Exception("Pin invalido")	
		}
		persona.pin(pin)		
	}
	method existeCuenta(persona){
		return cuentas.any({p => p.equals(persona)})
	}
	method abrirCuenta(persona, pin){
		if(self.existeCuenta(persona)){
			throw new Exception("Ya existe la cuenta")		
		}
		self.cambiarPin(persona,pin)
		cuentas.add(persona)
	}
	method consultarSaldo(persona, pin){
		if (!self.pinCorrecto(persona, pin)){
			throw new Exception("Pin incorrecto")
		}
		return persona.sueldo()
	}
	method depositar(persona, monto){
		persona.sueldo(persona.sueldo() + monto)
	}
	method retirar(persona, monto, pin){
		if (!self.pinCorrecto(persona, pin)){
			throw new Exception("Pin Incorrecto")
		}
		if(persona.sueldo() < monto){
			throw new Exception("Saldo insuficiente")
		}
		persona.sueldo(persona.sueldo() - monto)
	}
	method transferir(persona, otraPersona, monto, pin){
		if(self.existeCuenta(otraPersona)){
			self.retirar(persona, monto, pin)
			self.depositar(otraPersona, monto)
			}
		else throw new Exception("Cuenta inexistente")
	}
}