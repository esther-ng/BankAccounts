require_relative "account"
require_relative "savings_account"
require_relative "checking_account"
require_relative "money_market_account"
#
# puts "\nTest Code Wave 1: "
#
# puts "New account with initial negative balance: "
# begin
#   wave_1_neg = Bank::Account.new("5555", -10, 2016-03-25)
# rescue
#   puts "Rescued: Cannot open a new account with that balance."
# end
#
# wave_1_new = Bank::Account.new("4444", 50000, 2016-03-25)
# puts "New account: #{wave_1_new.to_s}"
# puts "ID: #{wave_1_new.id}"
# puts "Balance: #{sprintf('$%0.02f', wave_1_new.balance / 100)}"
# wave_1_new.withdraw(5000)
# puts "Withdraw $50.00, new balance: #{sprintf('$%0.02f', wave_1_new.balance / 100)}"
#
# wave_1_new.deposit(5000)
# puts "Deposit $50.00, new balance: #{sprintf('$%0.02f', wave_1_new.balance / 100)}"
#
# puts "Withdrawal that causes balance to go negative: "
# wave_1_new.withdraw(51000)
#
# puts "\nTest Code Wave 2"
# puts "self.all: " + Bank::Account.all.to_s
# puts "self.find('15155'): " + Bank::Account.find("15155").to_s
# puts "self.all_with_owners: " +  Bank::Account.all_with_owners.to_s
# puts "self.find('15155', true) returns account with owner: " + Bank::Account.find("15155", true).to_s
# puts "Bank::Owner.find('22'): " + Bank::Owner.find("22").to_s
# puts "Bank::Owner.all: " + Bank::Owner.all.to_s
#
# puts "\nTest Code Wave 3"
#
# puts "New Savings Account with initial balance less than $10: "
# begin
#   wave_3_low = SavingsAccount.new("6666", 800, 2016-03-25)
# rescue
#   puts "Rescued: Cannot open a new account with that balance."
# end
#
# wave_3_savings = SavingsAccount.new("7777", 50000, 2016-03-25)
# puts "New savings account: #{wave_3_savings.to_s}"
# puts "ID: #{wave_3_savings.id}"
# puts "Balance: #{sprintf('$%0.02f', wave_3_savings.balance / 100)}"
#
# wave_3_savings.withdraw(5000)
# puts "Withdraw $50.00, incur $2 transaction fee, new balance: #{sprintf('$%0.02f', wave_3_savings.balance / 100)}"
#
# wave_3_savings.deposit(5000)
# puts "Deposit $50.00, new balance: #{sprintf('$%0.02f', wave_3_savings.balance / 100)}"
#
# puts "Withdrawal that causes balance to go below $10 minimum: "
# wave_3_savings.withdraw(48700)
#
# puts "Add 0.25% interest in the amount of: $#{wave_3_savings.add_interest(0.25).to_s}"
# puts "The new balance with interest is: " + sprintf('$%0.02f',  wave_3_savings.balance / 100)
#
# wave_3_checking = CheckingAccount.new("8888", 50000, 2016-03-25)
# puts "New checking account: #{wave_3_checking.to_s}"
# puts "ID: #{wave_3_checking.id}"
# puts "Balance: #{sprintf('$%0.02f', wave_3_checking.balance / 100)}"
#
# wave_3_checking.withdraw(5000)
# puts "Checking account, $50.00 withdrawal with $1 fee, new balance: #{sprintf('$%0.02f', wave_3_checking.balance / 100)}"
#
# puts "Withdrawal that causes balance to go negative: "
# wave_3_checking.withdraw(45000)
#
# wave_3_checking.deposit(5000)
# puts "Deposit $50.00, new balance: #{sprintf('$%0.02f', wave_3_checking.balance / 100)}"
#
# 3.times do
#   wave_3_checking.withdraw_using_check(100)
#   puts "Withdraw $1.00 using check, with #{wave_3_checking.free_checks.to_s} free checks left: " + sprintf('$%0.02f', wave_3_checking.balance / 100)
# end
#
# wave_3_checking.withdraw_using_check(100)
# puts "Withdraw using check, with no free checks left, fee is $2: " + sprintf('$%0.02f', wave_3_checking.balance / 100)
#
# wave_3_checking.withdraw_using_check(50100)
# puts "Overdraft up to $10 with check, balance is " + sprintf('$%0.02f', wave_3_checking.balance / 100)
#
#
# wave_3_checking.withdraw_using_check(100)
# puts "^^Overdraft over $10 with check, balance unchanged at: " + sprintf('$%0.02f', wave_3_checking.balance / 100)
#
# wave_3_checking.reset_checks
# puts "Reset checks, new free check count = #{wave_3_checking.free_checks.to_s}"

puts "\nTest Code Wave 3 OEs"
puts "New account with insufficient initial balance: "
begin
  insufficient_initial = MoneyMarketAccount.new("5555",10000, 2016-03-25)
rescue
  puts "Rescued: Cannot open a new account with that balance."
end

m = MoneyMarketAccount.new(99999, 1000000, 2016-02-15)

puts "New account: #{m.to_s}"
puts "ID: #{m.id}"
puts "Balance: #{sprintf('$%0.02f', m.balance / 100)}"
puts "You have used #{m.transactions} transactions of #{MoneyMarketAccount::TRANSACTIONS_ALLOWED} transactions allowed."

m.withdraw(5000)
puts "Withdraw $50.00, new balance is below minimum and charged $100 fee so balance is at #{sprintf('$%0.02f', m.balance / 100)}, and transactions max out to allotted #{m.transactions}."

m.deposit(15000)
puts "Deposit $150.00, new balance: #{sprintf('$%0.02f', m.balance / 100)} and does not count toward transactions #{m.transactions}."

m.reset_transactions
puts "Reset transactions back to zero, current count is #{m.transactions}."

m.deposit(50000)
puts "Deposit $500.00, counts as a transaction against alloted. You have used #{m.transactions} transactions of #{MoneyMarketAccount::TRANSACTIONS_ALLOWED} transactions allowed."

m.withdraw(5000)
puts "Withdraw $50.00, new balance is not below minimum and so balance is at #{sprintf('$%0.02f', m.balance / 100)}, and You have used #{m.transactions} transactions of #{MoneyMarketAccount::TRANSACTIONS_ALLOWED} transactions allowed."

puts "Add interest at 0.25% which amounts to #{sprintf('$%0.02f', m.add_interest(0.25) / 100)} and makes the balance #{sprintf('$%0.02f', m.balance / 100)}."
