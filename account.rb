require_relative 'owner'
# require 'money'
require 'csv'
# the find method should use the all method
# make sure to reference the csv file in the support folder
# csv balances are in cents

# I18n.enforce_available_locales = false # this fixes an error in the money gem

module Bank
  class Account
    attr_accessor :id, :balance, :owner, :minimum_balance

    LOW_INITIAL_BALANCE = "Cannot open a new account with less than the minimum balance."
    WITHDRAWAL_WARNING = "Cannot make a withdrawal that will result in dropping below the minimum balance."
    MINIMUM_BALANCE = 0

    def initialize(id, balance, opendate)
      unless balance.to_i >= self.class::MINIMUM_BALANCE
        raise ArgumentError.new(LOW_INITIAL_BALANCE)
      end
      @balance = balance.to_i
      @id = id
      @opendate = opendate
      @owner = owner
    end

# this both uploads the accounts from the csv file and returns an array of account objects created from the file data
    def self.all
      accounts = []
      CSV.read('support/accounts.csv').each do |line|
        balance = line[1]
        accounts << self.new(line[0], balance, line[2])
      end
      accounts
    end

# accepts an id and returns the matching account object
    def self.find(id)
      accounts = self.all
      accounts.each do |account|
        if account.id == id
          return account
        end
      end
    end

# use csv file to add owners to respective accounts and return a new array of account objects with owners
    def self.all_with_owners
      accounts_with_owners = []
      CSV.read('support/account_owners.csv').each do |line|
        account = self.find(line[0])
        owner = Owner.find(line[1])
        account.owner = owner
        accounts_with_owners << account
      end
      accounts_with_owners
    end

    def withdraw(amount, fee = 0)
      if (@balance - amount - fee) < self.class::MINIMUM_BALANCE
        puts WITHDRAWAL_WARNING
      else
        @balance -= (amount + fee)
      end
      return @balance
    end

    def deposit(amount)
      @balance += amount
      return @balance
    end
  end
end
