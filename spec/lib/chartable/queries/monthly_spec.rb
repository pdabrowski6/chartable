require 'spec_helper'

describe Chartable::Queries::Monthly do
  describe '.call' do
    it 'returns yearly statistics' do
      Timecop.travel(Date.parse('10/10/2018')) { FactoryBot.create :user }
      Timecop.travel(Date.parse('10/11/2018')) { FactoryBot.create :user }

      expect(described_class.call(User.all, on: 'created_at')).to eq({"November 2018" => 1, "October 2018" => 1})
    end
  end
end
