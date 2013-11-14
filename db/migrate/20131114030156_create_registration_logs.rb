class CreateRegistrationLogs < ActiveRecord::Migration
  def change
    create_table :registration_logs do |t|
      t.string :email, size: 255, null: false
      t.string :ip,    size: 30,  null: false, index: true
      t.references :blog,         null: false, index: true
      t.datetime :registered,     null: false
    end
  end
end
