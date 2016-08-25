require_relative 'account'

class CheckingAccount < Bank::Account
  def initialize(id, balance, opendate, minimum_balance = 0)
    super
    @free_checks = 3
  end

  def withdraw(amount, fee = 100)
    super
  end

  def withdraw_using_check(amount)
    if @free_checks <= 0
      fee = 200
    else
      fee = 0
    end
    if (@balance - amount - fee) < -10
      puts WITHDRAWAL_WARNING
    else
      @balance -= (amount + fee)
    end
    return @balance
  end

  def reset_checks
    @free_checks = 3
  end
end
