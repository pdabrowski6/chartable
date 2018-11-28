require 'spec_helper'

describe Chartable::Queries::Daily do
  describe '.call' do
    it 'returns yearly statistics' do
      Timecop.travel(Date.parse('10/10/2018')) { FactoryBot.create :user }
      Timecop.travel(Date.parse('11/10/2018')) { FactoryBot.create :user }
      
      expect(described_class.call(User.all, on: 'created_at', order: 'desc')).to eq({"October 09, 2018" => 1, "October 10, 2018" => 1})
    end
  end
end
