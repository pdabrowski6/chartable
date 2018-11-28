require 'spec_helper'

describe Chartable::Queries::Weekly do
  describe '.call' do
    it 'returns yearly statistics' do
      Timecop.travel(Date.parse('02/02/2018')) { FactoryBot.create :user }
      Timecop.travel(Date.parse('15/02/2018')) { FactoryBot.create :user }

      expect(described_class.call(User.all, on: 'created_at', order: 'desc')).to eq({"01/28/2018 - 02/03/2018" => 1, "02/11/2018 - 02/17/2018" => 1})
    end
  end
end
