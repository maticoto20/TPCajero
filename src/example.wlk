class Cuenta{
	var property persona
	var property pin
	var saldo = 0
	
	method pinCorrecto(unPin){
		return pin.equals(unPin)
	}
	method retirar(monto, unPin){
		if (!self.pinCorrecto(unPin)){
			throw new Exception("Pin Incorrecto")
		}
		if(saldo < monto){
			throw new Exception("Saldo insuficiente")
		}
		saldo -= monto
	}
	method depositar(monto){
		saldo += monto
	}
	method consultarSaldo(unPin){
		if (!self.pinCorrecto(unPin)){
			throw new Exception("Pin incorrecto")
		}
		return saldo
	}
}

object cajero{
	var cuentas = []
	method pinValido(pin){
		return true
	}

	method cambiarPin(cuenta, pin){
		if (!self.pinValido(pin)){
			throw new Exception("Pin invalido")	
		}
		cuenta.pin(pin)
	}
	method existeCuenta(persona){
		return cuentas.any({cuenta => cuenta.persona().equals(persona)})
	}
	method abrirCuenta(persona, pin){
		if(self.existeCuenta(persona)){
			throw new Exception("Ya existe la cuenta")
		}
		cuentas.add(new Cuenta(persona = persona, pin = pin))
	}
	method getCuenta(persona){
		return cuentas.find({cuenta => cuenta.persona() == persona})
	}
	method consultarSaldo(persona, pin){
		return self.getCuenta(persona).consultarSaldo(pin)
	}
	method depositar(persona, monto){
		self.getCuenta(persona).depositar(monto)
	}
	method retirar(persona, monto, pin){
		self.getCuenta(persona).retirar(monto, pin)
	}
	method transferir(cuenta, otraCuenta, monto, pin){
		if(self.existeCuenta(otraCuenta)){
			self.retirar(cuenta, monto, pin)
			self.depositar(otraCuenta, monto)
			}
		else throw new Exception("Cuenta inexistente")
	}
}