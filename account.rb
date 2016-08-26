require_relative 'owner'
require 'csv'

# require 'money'
# I18n.enforce_available_locales = false # this fixes an error in the money gem

# csv balances are in cents

module Bank
  class Account
    attr_accessor :id, :balance, :owner

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
      return accounts
    end

# accepts an id and returns the matching account object
    def self.find(id, owner = false)
      if owner == true
        accounts = self.all_with_owners
      else
        accounts = self.all
      end
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
        account.owner = Owner.find(line[1])
        accounts_with_owners << account
      end
      accounts_with_owners
    end

    def withdraw(amount, fee = 0)
      if not_allowed?(amount, fee)
        puts self.class::WITHDRAWAL_WARNING
      else
        if_allowed(amount, fee)
      end
      return @balance
    end

    def remaining_balance(amount, fee = 0)
      return @balance - amount - fee
    end

    def not_allowed?(amount, fee)
      remaining_balance(amount, fee) < self.class::MINIMUM_BALANCE
    end

    def if_allowed(amount, fee)
      @balance = remaining_balance(amount, fee)
    end

    def deposit(amount)
      @balance += amount
      return @balance
    end
  end
end
