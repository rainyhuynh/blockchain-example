class Bank

    attr_reader :owner, :total_supply

    def initialize(attribute)
      @owner = attribute[:owner].downcase
      @total_supply = attribute[:total_supply]
      @balances = { @owner.to_sym => @total_supply}
      # { "Rainy": 1000000}
    end

    def create_account(username)
        @balances[username.downcase.to_sym] = 0
    end

    def balance_of(username)
        @balances[username.downcase.to_sym]
    end

    def transfer(from, to, amount)

        return if balance_of(from) < amount
        return if amount < 0

        @balances[from.downcase.to_sym] -= amount
        @balances[to.downcase.to_sym] += amount
    end
end