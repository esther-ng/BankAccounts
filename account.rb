require_relative 'owner'
require 'money'
require 'csv'
# the find method should use the all method
# make sure to reference the csv file in the support folder
I18n.enforce_available_locales = false

module Bank
  class Account
    attr_accessor :id, :balance, :owner

    # @@accounts = []

    def initialize(id, balance, opendate, owner = nil)
      unless balance >= 0
        raise ArgumentError.new("Cannot open a new account with a negative balance.")
      end
      @owner = owner
      @balance = Money.new(balance, "USD")
      @id = id
      @opendate = opendate
    end

    # def self.all
    #   return @@accounts
    # end import_accounts(filename)
# this both uploads the accounts from the csv file and returns it
    def self.all
      accounts = []
      CSV.read('support/accounts.csv').each do |line|
        balance = Money.new(line[1], "USD")
        accounts << self.new(line[0], balance, line[2])
      end
      # CSV.read('support/account_owners.csv').each do |line|
      #   (self.find(line[0])).owner = Owner.find(line[1])
      # end
      accounts
    end

    def self.find(id)
      accounts = self.all
      accounts.each do |account|
        if account.id == id
          return account
        end
      end
    end

# add owner from csv to instance of account THIS WORKS!
    def self.all_with_owners
      self.all
      accounts_with_names = []
      CSV.read('support/account_owners.csv').each do |line|
        account = self.find(line[0])
        owner = Owner.find(line[1])
        account.owner = owner
        accounts_with_names << account
      end
      accounts_with_names
    end


    def withdraw(amount)
      amount = Money.new( amount , "USD")
      unless (@balance - amount) >= 0
        raise ArgumentError.new("Cannot make a withdrawal that will result in a negative balance.")
      end
      @balance -= amount
      return @balance.format
    end

    def deposit(amount)
      amount = Money.new( amount , "USD")
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

#
#
# def add_owner
#   CSV.read('support/account_owners.csv').each do |line|
#     (Bank::Account.find(line[0])).owner = accounts.find(line[1])
#   end
# end
