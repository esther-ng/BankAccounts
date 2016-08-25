require_relative 'account'

class SavingsAccount < Bank::Account
  def initialize(id, balance, opendate, minimum_balance = 1000)
    super
    # @withdrawal_fee = 200
  end

  def withdraw(amount, fee = 200)
    super
  end

  def add_interest(rate)
    interest = @balance * (rate/100)
    @balance += interest
    return interest
  end
end
