require_relative 'account'

class SavingsAccount < Bank::Account
  MINIMUM_BALANCE = 1000

  def withdraw(amount, fee = 200)
    super
  end

  def add_interest(rate)
    interest = @balance * (rate/100)
    @balance += interest
    return interest
  end
end
