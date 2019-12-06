require 'spec_helper'
require_relative '../client.rb'

RSpec.describe Client do
    let(:bank) { Bank.new({owner: "Rainy", total_supply: 1_000_000}) }

    it "create new bank account if one does not exist" do
        client = Client.new(bank, 'fiona')
        expect(client.get_balance).to eq(0)  
    end

    it "does not create bank account if one does exits" do
        client = Client.new(bank, 'Rainy')
        expect(client.get_balance).to eq(1_000_000)  
    end

    it "can excute transfers" do
        client1 = Client.new(bank, 'rainy')
        client2 = Client.new(bank, 'fiona')

        client1.transfer('fiona', 4500)
        expect(client2.get_balance).to eq(4500)
        expect(client1.get_balance).to eq(995500)    
    end
    
    
end
