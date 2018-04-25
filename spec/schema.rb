ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.timestamps
  end

end
