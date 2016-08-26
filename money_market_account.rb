require_relative 'account'

class MoneyMarketAccount < Bank::Account
  MINIMUM_BALANCE = 1000000
  WITHDRAWAL_WARNING = "Sorry, no more transactions left for this month."
  def initialize(id, balance, opendate)
    super
      @remaining_transactions = 6
  end

  def withdraw(amount, fee = 0)
    super(amount, fee)
  end

  def not_allowed?(amount, fee)
    @remaining_transactions <= 0
  end

  def if_allowed(amount, fee)
    if remaining_balance(amount, fee) < 1000000
      fee = 10000
      @remaining_transactions = 0
    else
      @remaining_transactions -= 1
    end
    @balance = remaining_balance(amount, fee)
  end

  def add_interest(rate)
    interest = @balance * (rate/100)
    @balance += interest
    return interest
  end
end
