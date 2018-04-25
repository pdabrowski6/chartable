require 'spec_helper'

describe Chartable::Queries::Quarterly do
  describe '.call' do
    it 'returns yearly statistics' do
      Timecop.travel(Date.parse('10/02/2018')) { FactoryBot.create :user }
      Timecop.travel(Date.parse('10/06/2018')) { FactoryBot.create :user }

      expect(described_class.call(User.all, on: 'created_at')).to eq({"Q1 2018" => 1, "Q2 2018" => 1})
    end
  end
end
