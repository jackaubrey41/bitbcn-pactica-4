pragma solidity ^0.4.25;

contract Inbox {                //Nombre del contrato se inicia con mayúsculas para indicar que es una clase
//    string public message;    // type = string, visibility= public, nombre = message
      string private message;   // variable declarada privada puedo escribir pero no puedo leerla

/*
    function Inbox (string _message) public {   // constructor funcion. Parámetro string
        message = _message                      // Inicializamos la variable con el parámetro.    
    }  */
    
    constructor (string _message) public {      // sintaxis en nuevas versiones de compilador
        message = _message;                     // estamos escribiendo un mensaje en la blockchain 
    }                                           // al hacer el deploy y luego leyendolo.
    
    function setMessage (string _message) public {
        message = _message;
    }
    
    function getMessage () public view returns (string) {
        return message;
    }
    
}

