class Client
    
    attr_reader :bank, :username

    def initialize(bank, username)
        @bank = bank
        @username = username
        find_or_create_account(username)
    end

    def find_or_create_account(username)
        if get_balance.nil?
            bank.create_account(username)
        end
    end

    def get_balance
        bank.balance_of(username)
    end

    def transfer(to, amount)
        bank.transfer(username, to, amount)
    end
end