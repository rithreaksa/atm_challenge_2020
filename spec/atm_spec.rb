require './lib/atm.rb'
require 'date'

describe Atm do
    let (:account) {instance_double('Account')}

    before do
        allow(account).to receive(:balance).and_return(100)
        allow(account).to receive(:balance=)
    end

    it 'has 1000$ on initialize' do
        expect(subject.funds).to eq 1000
    end

    it 'funds are reduced at withdraw' do
        subject.withdraw(50, account)
        expect(subject.funds).to eq 950
    end

    it 'rejects withdraw if account has insufficient funds' do
        expected_output = { status: false, message: ' insufficient funds', date: Date.today }
        expect(subject.withdraw(105, account)).to eq expected_output
    end

    it 'reject withdraw if ATM has insufficent funds' do
        subject.funds = 50
        expect= { status: false, message: 'insufficent funds in ATM', date: Date.today }
        expect(subject.withdraw(100, account)).to eq expected_output
    end

    it 'allow withdraw if the account has enough balance.' do
        expected_output = {status: true, message: 'success', date:Date.today, amount: 45}
        expect(subject.withdraw(45, account)). to eq expected_output
    end
end