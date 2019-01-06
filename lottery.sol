pragma solidity ^0.4.25;

contract Lottery {
    struct Player {
        address wallet;
        string name;
    }
    
    address public manager;
    Player[] public players;
    address public winner;
    
    modifier restrinctedPickWinner(){
        require (msg.sender == manager);
        require (players.length > 0 );
        require (winner == 0x0); // si ya existe un ganador no ejecutes pickWinner
        
        _;
    }
    
    constructor () public {
        manager = msg.sender; // Quien desplieaga el contrato será el manager.
    }
    
    // quien entre a la lotería deberá pagar
    function enter() public payable {
        // sólo se ejecuta si entramos con más de 0.1 ether.
        require (msg.value > 0.1 ether);
        bool isPlayer = false;
        
        for (uint i=0; i < players.length; i++){
            // compara la direccion del candidato con cada dirección del array de players
            // si es igual la igualdad es  True y la función OR inicializa a true isPlayer.
            // queda en true y no se hace el push de la nueva direccion
            isPlayer = isPlayer || (msg.sender == players[i]);
        }
       // if (!isPlayer) {
        require (!isPlayer);
        
        players.push (msg.sender);
        
    } 

    // retorna la dirección del ganador
    function pickWinner() public  restrinctedPickWinner returns(address) {
        // evitamos el if else con require
        // si el require no se cumple la transación en blockchain da un error
        // y no se ejecuta . Es el comportamiento deseado.
       // require ( msg.sender == manager);
        
        winner = players[random() % players.length]; // el número aleatorio modulo número de jugadores
        
        winner.transfer (address(this).balance);
        
        return winner;
 
 /*   if  (msg.sender == manager) {
        winner = players[random()];
        return winner;
        } else {
            return 0x0;
        }
*/ 
    }
    
    // random es privda puesto que no es necesario que nadie pueda
    // acceder para ejecutarlo
    function random() private view returns (uint) {
        return uint (keccak256(block.difficulty, now, players));
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance; // retorna el balance del smart contrcat. función this accede a Scontract
    }
    
}
