// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title SimpleEscrow
 * @author ZerosAndOnes
 * @notice A trust-minimized escrow contract for secure payments between i_buyer and i_seller.
 * @dev Follows Day 7 of the 30-Day Solidity Challenge. Uses enums and custom errors for gas savings.
 */

contract SimpleEscrow {

    // Errors
    error NotBuyer();
    error NotSeller();
    error InvalidState();
    error DepositAlreadyMade();
    error ZeroDepositNotAllowed();
    error WithdrawalFailed();


    // Events
    event Deposited(address indexed i_buyer, uint256 amount);
    event Withdrawn(address indexed i_seller, uint256 amount);

    // State Variables
    address public immutable i_buyer;
    address public immutable i_seller;
    uint256 public depositAmount;

    enum EscrowState { 
        NotInitiated, 
        Deposited, 
        Released 
    }

    EscrowState public state;


    // Modifiers
    modifier onlyBuyer() {
        if (msg.sender != i_buyer) {
            revert NotBuyer();
        }
        _;
    }

    modifier onlySeller() {
        if (msg.sender != i_seller) {
            revert NotSeller();
        }
        _;
    }

    modifier inState(EscrowState expected) {
        if (state != expected) {
            revert InvalidState();
        }
        _;
    }

    // Constructor
    constructor(address _i_seller) {
        if (_i_seller == address(0)) {
            revert();
        }
        i_buyer = msg.sender;
        i_seller = _i_seller;
        state = EscrowState.NotInitiated;
    }

    // External Functions

    /**
     * @notice Deposit ETH into escrow (only i_buyer can deposit)
     * @dev Only one deposit allowed; amount must be greater than zero
     */
    function deposit()
        external
        payable
        onlyBuyer
        inState(EscrowState.NotInitiated)
    {
        if (msg.value == 0) {
            revert ZeroDepositNotAllowed();
        }

        depositAmount = msg.value;
        state = EscrowState.Deposited;
        emit Deposited(msg.sender, msg.value);
    }

    /**
     * @notice Withdraw escrowed funds (only i_seller after i_buyer releases)
     * @dev Entire balance is transferred to i_seller
     */
    function withdraw()
        external
        onlySeller
        inState(EscrowState.Deposited)
    {
        state = EscrowState.Released;
        emit Withdrawn(msg.sender, depositAmount);

        (bool success, ) = i_seller.call{value: depositAmount}("");
        if (!success) {
            revert WithdrawalFailed();
        }
    }

    // View Functions
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}