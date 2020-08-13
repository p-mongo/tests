class CreateEmails < ActiveRecord::Migration[5.2]
  def change
    create_table :emails do |t|
      t.string :c_fk

      t.timestamps
    end
  end
end
