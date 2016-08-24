require_relative 'owner'
require 'money'
require 'csv'
# the find method should use the all method
# make sure to reference the csv file in the support folder
I18n.enforce_available_locales = false

module Bank
  class Account
    attr_accessor :id, :balance, :owner

    @@accounts = []

    def initialize(id, balance, opendate)
      unless balance >= 0
        raise ArgumentError.new("Cannot open a new account with a negative balance.")
      end
      @owner = owner
      @balance = Money.new(balance * 100, "USD")
      @id = id
      @opendate = opendate
    end

    def self.all
      return @@accounts
    end

    def self.import_accounts(filename)
      @@accounts = []
      CSV.read(filename).each do |line|
        balance = Money.new(line[1], "USD")
        @@accounts << self.new(line[0], balance, line[2])
      end
    end

    def self.find(id)
      accounts = self.all
      accounts.each do |account|
        if account.id == id
          return account
        else
          return "That account does not exist."
        end
      end
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
