require_relative 'account'

class CheckingAccount < Bank::Account
  MINIMUM_BALANCE = 0

  attr_accessor :free_checks

  def initialize(id, balance, opendate)
    super
    @free_checks = 3
    @overdraft = -1000
  end

  def withdraw(amount, fee = 100)
    super
  end

  def withdraw_using_check(amount)
    if @free_checks < 1
      fee = 200
    else
      fee = 0
      @free_checks -= 1
    end
    if remaining_balance(amount, fee) < @overdraft
      puts WITHDRAWAL_WARNING
    else
      @balance = remaining_balance(amount, fee)
    end
    return @balance
  end

  def reset_checks
    @free_checks = 3
  end
end
