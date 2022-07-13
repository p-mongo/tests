class CreateShapes < ActiveRecord::Migration[5.2]
  def change
    create_table :shapes do |t|

      t.string :type
      t.string :ic

      t.string :name

      t.integer :i

      t.timestamps
    end
  end
end
