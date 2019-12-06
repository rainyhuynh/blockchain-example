require 'pry'
require 'spec_helper'
require_relative '../bank.rb'

RSpec.describe Bank do

    let(:bank) { Bank.new({owner: "Rainy", total_supply: 1_000_000}) }

    it "has an owner with an initial balance" do
        expect(bank.owner).to eq("rainy")
        expect(bank.total_supply).to eq(1_000_000)
        expect(bank.balance_of('rainy')).to eq(1_000_000)
    end

    it "can create new bank account" do
        bank.create_account('Fiona')
        expect(bank.balance_of('fiona')).to eq(0)
    end

    it "allow clients to transfer funds to each other" do
        bank.create_account('Fiona')
        bank.transfer('rainy', 'fiona', 50_000)
        expect(bank.balance_of('rainy')).to eq(950_000)
        expect(bank.balance_of('fiona')).to eq(50_000)
    end

    it "don't allow clients transfer more than they have" do
        bank.create_account('teo')
        bank.transfer('rainy', 'teo', 9_000_000)
        expect(bank.balance_of("rainy")).to eq(1_000_000) 
        expect(bank.balance_of("teo")).to eq(0) 
    end
    
    it "allow client to transfer all of their money" do        
        bank.create_account('fin')
        bank.transfer('rainy', 'fin', 1_000_000)
        expect(bank.balance_of('rainy')).to eq(0) 
        expect(bank.balance_of('fin')).to eq(1_000_000) 
    end

    it "don't allow negative amount" do        
        bank.create_account('ti')
        bank.transfer('rainy', 'ti', -1_000_000)
        expect(bank.balance_of('rainy')).to eq(1_000_000) 
        expect(bank.balance_of('ti')).to eq(0) 
    end
    
end
