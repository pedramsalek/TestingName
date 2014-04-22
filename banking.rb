class Person
    
    def initialize (name, cash)
        @name = name
        @cash = cash
        @accounts = Hash.new
        puts "Hi, #{@name}. You have #{@cash}!"
    end
    
    def get_name
        return @name
    end
    
    def get_account_balance(account)
        return @accounts[account]
    end
    
    def get_cash_balance
        return @cash
    end
    
    def get_accounts_summary
        puts "******************"
        puts "Cash and Accounts summary for #{@name}:"
        puts 'Available Cash = ' + @cash.to_s
        @accounts.each {|key,value| puts "#{key}: #{value}"}
        puts "******************"
    end
    
    def new_account(account)
        if @accounts.has_key? (account)
            puts "A #{account} already exists for #{@name}!"
            else
            @accounts.merge!(account => 0)
            puts @name + ', thanks for opening an account at ' +     account + '!'
        end
    end
    
    def update_cash (amount, increase_or_decrease)
        if increase_or_decrease == "increase"
            @cash += amount
            else
            @cash -= amount
        end
        return @cash
    end
    
    def update_account (amount, account, increase_or_decrease)
        if increase_or_decrease == "increase"
            @accounts[account] += amount
            else
            @accounts[account] -= amount
        end
        return @accounts[account]
    end
    
    def check_cash (amount)
        if @cash - amount < 0
            return false
            else
            return true
        end
    end
    
    def check_account(amount, account)
        if @accounts[account] - amount < 0
            return false
            else
            return true
        end
    end
    
end

class Bank
    
    def initialize (bank_name)
        @bank_name = bank_name
        @bank_balance = 0
        puts "#{@bank_name} bank was just created."
    end
    
    def get_bank_name
        return @bank_name
    end
    
    def get_bank_balance
        return @bank_balance
    end
    
    def open_account (person)
        person.new_account(@bank_name)
    end
    
    def update_bank_balance (amount, increase_or_decrease)
        if increase_or_decrease == "increase"
            @bank_balance += amount
            else
            @bank_balance -= amount
        end
    end
    
    def deposit (person, amount)
        if person.check_cash(amount)
            puts "#{person.get_name} deposited $#{amount.to_s} to #{@bank_name}. #{person.get_name} has $#{person.update_cash(amount,'decrease').to_s}. #{person.get_name}'s  #{@bank_name} account has $#{person.update_account(amount, @bank_name, 'increase').to_s}."
            update_bank_balance(amount, 'increase')
            else
            puts "Not enough cash to conduct this deposit. You only have $#{person.get_cash_balance}."
        end
    end
    
    def withdraw (person, amount)
        if person.check_account(amount, @bank_name)
            puts "#{person.get_name} withdrew $#{amount.to_s} from #{@bank_name}. #{person.get_name} has $#{person.update_cash(amount,'increase').to_s}. #{person.get_name}'s #{@bank_name} account has $#{person.update_account(amount, @bank_name, 'decrease').to_s}."
            update_bank_balance(amount, 'decrease')
            else
            puts "Not enough balance to conduct this withdraw. You only have $#{person.get_account_balance(@bank_name)} in your #{@bank_name} account."
        end
    end
    
    def transfer(person, account, amount)
        if person.check_account(amount, @bank_name)
            person.update_account(amount, @bank_name,'decrease')
            person.update_account(amount, account.get_bank_name, 'increase')
            puts "#{person.get_name} transfered $#{amount.to_s} from the #{@bank_name} account to the #{account.get_bank_name} account. The #{@bank_name} account has $#{person.get_account_balance(@bank_name).to_s} and the #{account.get_bank_name} account has #{person.get_account_balance(account.get_bank_name).to_s}."
            update_bank_balance(amount, 'decrease')
            account.update_bank_balance(amount, 'increase')
            
            else
            puts "Not enough balance to conduct this transfer. You only have $#{person.get_account_balance(@bank_name)} in your #{@bank_name} account."
        end
    end
end



chase = Bank.new("JP Morgan Chase")
wells_fargo = Bank.new("Wells Fargo")
me = Person.new("Shehzan", 500)
friend1 = Person.new("John", 1000)
chase.open_account(me)
chase.open_account(friend1)
wells_fargo.open_account(me)
wells_fargo.open_account(friend1)

chase.deposit(me, 200)
chase.deposit(friend1, 300)
chase.withdraw(me, 50)

chase.transfer(me, wells_fargo, 100)

puts me.get_accounts_summary

puts 'Chase balance: $' + chase.get_bank_balance.to_s
puts 'Wells Fargo balance: $' + wells_fargo.get_bank_balance.to_s
