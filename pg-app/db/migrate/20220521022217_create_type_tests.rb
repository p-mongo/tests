class CreateTypeTests < ActiveRecord::Migration[7.0]
  def change
    create_table :type_tests do |t|
      t.string :str
      t.decimal :dec
      t.time :t
      t.timestamp :ts
      t.hstore :hs
      t.text :a, array: true
      t.inet :i

      t.timestamps
    end
  end
end
