// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Game {

    struct Warrior {
        uint ID;
        uint Health;
        uint attackPower;
    }

    struct Monster {
        uint health;
        uint attackPower;
        uint reward;
    }

    constructor() {

        addMonster(100, 10, 100);
        addMonster(200, 20, 300);

    }

    mapping (address => Warrior) public warriors;

    Monster[] public monters;
    function attack() public {

    }

    function addMonster(uint _health, uint _attackPower, uint _reward) private {
        Monster memory monster;
        monster.health
    }
}