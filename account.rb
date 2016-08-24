require_relative 'owner'
require 'money'
# the find method should use the all method
# make sure to reference the csv file in the support folder
I18n.enforce_available_locales = false

module Bank
  class Account
    attr_accessor :balance, :owner

    def initialize(owner, balance)
      unless balance >= 0
        raise ArgumentError.new("Cannot open a new account with a negative balance.")
      end
      @owner = owner
      @balance = Money.new(balance * 100, "USD")
      id = Random.new
      @id = id.rand(100000...999999)
    end

    def withdraw(amount)
      amount = Money.new( amount * 100, "USD")
      unless (@balance - amount) >= 0
        raise ArgumentError.new("Cannot make a withdrawal that will result in a negative balance.")
      end
      @balance -= amount
      return @balance.format
    end

    def deposit(amount)
      amount = Money.new( amount * 100, "USD")
      @balance += amount
      return @balance.format
    end

    # def to_cents(num)
    #   return num * 100
    # end
    #
    # def to_dollar_and_cents(num)
    #   return num / 100
    # end
  end
end
