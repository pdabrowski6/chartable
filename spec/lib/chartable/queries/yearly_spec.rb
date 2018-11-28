require 'spec_helper'

describe Chartable::Queries::Yearly do
  describe '.call' do
    it 'returns yearly statistics' do
      Timecop.travel(Date.parse('10/10/2018')) { FactoryBot.create :user }
      Timecop.travel(Date.parse('10/10/2017')) { FactoryBot.create :user }

      expect(described_class.call(User.all, on: 'created_at', order: 'asc')).to eq({ 2017 => 1, 2018 => 1 })
    end
  end
end
