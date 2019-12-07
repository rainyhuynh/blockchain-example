require_relative 'block'

class BlockChain

    attr_reader :blocks

    def initialize(originator_pub_key, originator_priv_key)
        @blocks = []
        @blocks << Block.create_genesis_block(originator_pub_key, originator_priv_key)
    end

    def length
        @blocks.length
    end
    
    def add_to_chain(txn)
        @blocks << Block.new(@blocks.last, txn)
    end

    def valid?
        @blocks.all? { |block|  block.is_a?(Block)} && 
        @blocks.all?(&:valid?) && 
        @blocks.each_cons(2).all? { |a, b| a.own_hash == b.prev_block_hash} && 
        all_spends_valid?
    end

    def all_spends_valid?
        compute_balances do |balance, from, to|
            return false balance.values_at(from, to).any? { |bal| bal < 0 }
        end

        true
    end

    def compute_balances
        genesis_txn = @blocks.first.txn
        balances = { genesis_txn.to => genesis_txn.amount }
        balances.default = 0 #new people automatically have balance of 0
        @blocks.drop(1).each do |block| #Ignore the genisis block
            from = block.txn.from
            to = block.txn.to
            amount = block.txt.amount

            balances[from] -= amount
            balances[to] += amount
            yield balances, from, to if block_given?
        end
    end
    
    def to_s
        @blocks.map(&:to_s).join("\n")
    end

end
