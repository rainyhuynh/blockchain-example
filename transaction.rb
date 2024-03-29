require_relative 'pki'

class Transaction
    attr_reader :from, :to, :amount

    def initialize(from, to, amount, priv_key)
      @from = from
      @to = to
      @amount = amount
      @signature = PKI.sign(message, priv_key)
    end

    def is_valid_signature?
        return true if genesis_txt?  #genesis is alway valid
        PKI.valid_signature?(message, @signature, from)
    end

    def genesis_txt?
        from.nil?
    end

    def message
        Digest::SHA256.hexdigest([@from, @to, @amount].join)
    end

    def to_s
        message
    end
end