class CreateStamps < ActiveRecord::Migration[5.2]
  def change
    create_table :stamps do |t|
      t.time :t
      t.datetime :dt
      t.date :d

      t.timestamps
    end
  end
end
