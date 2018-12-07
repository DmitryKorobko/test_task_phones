class CreatePhones < ActiveRecord::Migration[5.2]
  def change
    create_table :phones do |t|
      t.integer  :phone
      t.string   :user_name
      t.boolean  :custom_phone

      t.timestamps
    end

    add_index :phones, %i( phone user_name ), unique: true, using: :btree
  end
end
