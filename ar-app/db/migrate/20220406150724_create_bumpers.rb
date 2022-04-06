class CreateBumpers < ActiveRecord::Migration[6.1]
  def change
    create_table :bumpers do |t|
      t.integer :car_id

      t.timestamps
    end
  end
end
