// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.1;
contract Account{
    uint256 public balance;
    uint256 public savings;
    uint256 _rate = 5; //0.5
    uint256 _noOfTimes = 6; //3 quarters by 2
    uint256 _time = 2; // 2 years 
    uint256 _interestAmount;

    constructor(uint256 _balance) zeroValue(_balance){
        balance = _balance;
    }

    /*
    @dev This function adds to the balance
    */

    function deposit(uint256 _amount) external zeroValue(_amount){
        balance += _amount;
    }

    /*
    @dev This function deducts from the balance
    */
    
    function save(uint256 _savingsAmount) external zeroValue(_savingsAmount) savingsAmountWithinRange( _savingsAmount){
        //   compound interest ==> (A = p(1 + (r/n))^(nt))
        balance -= _savingsAmount;
        uint256 A = _savingsAmount * ((1 + (_rate/100)/_noOfTimes)**(_noOfTimes * _time));
        savings += (A + _savingsAmount);

    }

    function widthdrawInterest(uint256 _savingsAmount) external {
        _interestAmount = _savingsAmount * ((1 + (_rate/100)/_noOfTimes)**(_noOfTimes * _time));
         savings -= _interestAmount;
         savings += _savingsAmount;
         balance += _interestAmount;
    }

    modifier savingsAmountWithinRange(uint256 _savingsAmount){
        require(_savingsAmount <= balance, "INSUFFICIENT FUNDS");
        _;
    }

    function withdraw(uint256 _amount) external  zeroValue(_amount){
        balance -= _amount;
    }



    modifier zeroValue(uint256 _amount){
       require(_amount > 0, "INVALID_AMOUNT");
       _;
    }

}

