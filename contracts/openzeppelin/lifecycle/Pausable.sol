// File: openzeppelin-zos/contracts/lifecycle/Pausable.sol
pragma solidity ^0.5.5;

import "../ownership/Ownable.sol";
import "../migrations/Migratable.sol";

/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 */
contract Pausable is Migratable, Ownable {
  event Pause();
  event Unpause();

  bool public paused = false;


  function initialize(address _sender) isInitializer("Pausable", "1.9.0")  public {
    Ownable.initialize(_sender);
  }

  /**
   * @dev Modifier to make a function callable only when the contract is not paused.
   */
  modifier whenNotPaused() {
    require(!paused);
    _;
  }

  /**
   * @dev Modifier to make a function callable only when the contract is paused.
   */
  modifier whenPaused() {
    require(paused);
    _;
  }

  /**
   * @dev called by the owner to pause, triggers stopped state
   */
  function pause() onlyOwner whenNotPaused public {
    paused = true;
    emit Pause();
  }

  /**
   * @dev called by the owner to unpause, returns to normal state
   */
  function unpause() onlyOwner whenPaused public {
    paused = false;
    emit Unpause();
  }
}