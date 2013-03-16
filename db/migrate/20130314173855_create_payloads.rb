class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string :login
      t.string :password_hash
      t.string :address
      t.datetime :date
      t.string :title
      t.string :message

      t.timestamps
    end
  end
end
