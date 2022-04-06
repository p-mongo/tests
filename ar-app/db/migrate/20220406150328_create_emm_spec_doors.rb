class CreateEmmSpecDoors < ActiveRecord::Migration[6.1]
  def change
    create_table :emm_spec_doors do |t|
      t.integer :car_id

      t.timestamps
    end
  end
end
