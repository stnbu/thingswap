pragma solidity >=0.5.0 <0.7.0;

contract ThingSwap {
    // Address of the creater of this contract. Only this address can "create" (register) thing.
    address public rancher;
    // A mapping stored of thing owners.
    mapping (uint256 => address) public thing;

    // When a thing is transferred between addresses, this event fires. (clients can "you have received thing", etc)
    event Sent(address from, address to, uint256 thingID);

    // Constructor code is only run when the contract is created. Record rancher's address.
    constructor() public {
        rancher = msg.sender;
    }

    // When a thing of thing is born, the rancher records the birth. thingID is the mongo _id (evaluated as hex).
    function birth(uint256 thingID) public {
        require(msg.sender == rancher);
        thing[thingID] = msg.sender;
    }

    // The current owner can transfer a thing to any other address.
    function transfer(address newOwner, uint256 thingID) public {
        require(thing[thingID] == msg.sender, "Address does not own this thing.");
        thing[thingID] = newOwner;
        emit Sent(msg.sender, newOwner, thingID);
    }
}
