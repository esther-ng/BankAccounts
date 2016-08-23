require_relative 'owner'

module Bank
  class Account
    attr_accessor :balance, :owner

    def initialize(owner, balance)
      unless balance >= 0
        raise ArgumentError.new("Cannot open a new account with a negative balance.")
      end
      @owner = owner
      @balance = balance
      id = Random.new
      @id = id.rand(100000...999999)
    end

    def withdraw(amount)
      unless (@balance - amount) >= 0
        raise ArgumentError.new("Cannot make a withdrawal that will result in a negative balance.")
      end
      @balance -= amount
      return @balance
    end

    def deposit(amount)
      @balance += amount
      return @balance
    end

    def to_cents(num)
      return num * 100
    end

    def to_dollar_and_cents(num)
      return num / 100
    end
  end
end
