require 'spec_helper'

describe Chartable::RangeQuery do
  describe '.call' do
    it 'returns default scope if both start and end dates are blank' do
      FactoryBot.create :user
      scope = User.all

      expect(described_class.call(scope, on: 'created_at')).to eq(scope)
    end

    it 'scopes by the start date' do
      Timecop.travel(Date.today - 2.days) { FactoryBot.create :user }
      user = FactoryBot.create :user
      scope = User.all

      result = described_class.call(
        scope, on: 'created_at', from: Date.today - 1.day
      )

      expect(result).to eq([user])
    end

    it 'scopes by the end date' do
      @first_user = nil
      Timecop.travel(Date.today - 2.days) { @first_user = FactoryBot.create :user }
      user = FactoryBot.create :user
      scope = User.all

      result = described_class.call(
        scope, on: 'created_at', to: Date.today - 1.day
      )

      expect(result).to eq([@first_user])
    end

    it 'scopes by the end and start date' do
      Timecop.travel(Date.today + 2.days) { FactoryBot.create :user }
      Timecop.travel(Date.today - 3.days) { FactoryBot.create :user }
      @right_user = nil
      Timecop.travel(Date.today - 1.day) { @right_user = FactoryBot.create :user }
      scope = User.all

      result = described_class.call(
        scope, on: 'created_at', to: Date.today, from: Date.today - 2.days
      )

      expect(result).to eq([@right_user])
    end
  end
end
