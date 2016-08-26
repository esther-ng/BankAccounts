require_relative "account"
require_relative "savings_account"
require_relative "checking_account"

puts "\nTest Code Wave 1: "

puts "New account with initial negative balance: "
begin
  wave_1_neg = Bank::Account.new("5555", -10, 2016-03-25)
rescue
  puts "Rescued: Cannot open a new account with that balance."
end

wave_1_new = Bank::Account.new("4444", 50000, 2016-03-25)
puts "New account: #{wave_1_new.to_s}"
puts "ID: #{wave_1_new.id}"
puts "Balance: #{wave_1_new.balance}"

puts "Withdraw 5000, new balance: #{wave_1_new.withdraw(5000)}"

puts "Deposit 5000, new balance: #{wave_1_new.deposit(5000)}"

puts "Withdrawal that causes balance to go negative: "
wave_1_new.withdraw(51000)

puts "\nTest Code Wave 2"
puts "self.all: " + Bank::Account.all.to_s
puts "self.find('15155'): " + Bank::Account.find("15155").to_s
puts "self.all_with_owners: " +  Bank::Account.all_with_owners.to_s
puts "self.find('15155', true) returns account with owner: " + Bank::Account.find("15155", true).to_s
puts "Bank::Owner.find('22'): " + Bank::Owner.find("22").to_s
puts "Bank::Owner.all: " + Bank::Owner.all.to_s

puts "\nTest Code Wave 3"

puts "New Savings Account with initial balance less than $10: "
begin
  wave_3_low = SavingsAccount.new("6666", 800, 2016-03-25)
rescue
  puts "Rescued: Cannot open a new account with that balance."
end

wave_3_savings = SavingsAccount.new("7777", 50000, 2016-03-25)
puts "New savings account: #{wave_3_savings.to_s}"
puts "ID: #{wave_3_savings.id}"
puts "Balance: #{wave_3_savings.balance}"

puts "Withdraw 5000, incur $2 transaction fee, new balance: #{wave_3_savings.withdraw(5000)}"

puts "Deposit 5000, new balance: #{wave_3_savings.deposit(5000)}"

puts "Withdrawal that causes balance to go below $10 minimum: "
wave_3_savings.withdraw(48700)

puts "Add 0.25% interest in the amount of: " + wave_3_savings.add_interest(0.25).to_s
puts "The new balance with interest is: " + wave_3_savings.balance.to_s

wave_3_checking = CheckingAccount.new("8888", 50000, 2016-03-25)
puts "New checking account: #{wave_3_checking.to_s}"
puts "ID: #{wave_3_checking.id}"
puts "Balance: #{wave_3_checking.balance}"

puts "Checking account, 5000 withdrawal with $1 fee, new balance: #{wave_3_checking.withdraw(5000)}"

puts "Withdrawal that causes balance to go negative: "
wave_3_checking.withdraw(45000)

puts "Deposit 5000, new balance: #{wave_3_checking.deposit(5000)}"

3.times do
  puts "Withdraw 100 using check, with #{wave_3_checking.free_checks.to_s} free checks left: " + wave_3_checking.withdraw_using_check(100).to_s
end

puts "Withdraw using check, with no free checks left: " + wave_3_checking.withdraw_using_check(100).to_s

puts "Overdraft up to $10 with check, balance is " + wave_3_checking.withdraw_using_check(50100).to_s


puts "Overdraft over $10 with check, balance unchanged at: " + wave_3_checking.withdraw_using_check(100).to_s
wave_3_checking.withdraw_using_check(100)

wave_3_checking.reset_checks
puts "Reset checks, new free check count = #{wave_3_checking.free_checks.to_s}"
