require_relative 'account'

class MoneyMarketAccount < Bank::Account
  MINIMUM_BALANCE = 1000000
  WITHDRAWAL_WARNING = "Sorry, no more transactions allowed for this month."
  TRANSACTIONS_ALLOWED = 6

  attr_accessor :transactions

  def initialize(id, balance, opendate)
    super
      @transactions = 0
  end

  def withdraw(amount, fee = 0)
    super(amount, fee)
  end

  def not_allowed?(amount, fee)
    @transactions >= TRANSACTIONS_ALLOWED
  end

  def if_allowed(amount, fee)
    if remaining_balance(amount, fee) < 1000000
      fee = 10000
      @transactions = TRANSACTIONS_ALLOWED
    else
      @transactions += 1
    end
    @balance = remaining_balance(amount, fee)
  end

  def deposit(amount)
    pre_deposit_balance = @balance
    post_deposit_balance = super(amount)
    if pre_deposit_balance < self.class::MINIMUM_BALANCE && post_deposit_balance >= self.class::MINIMUM_BALANCE
      return @balance
    else
      @transactions += 1
      return @balance
    end
  end

  def reset_transactions
    @transactions = 0
  end

  def add_interest(rate)
    interest = @balance * (rate/100)
    @balance += interest
    return interest
  end
end
