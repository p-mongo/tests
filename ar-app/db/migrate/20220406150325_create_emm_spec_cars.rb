class CreateEmmSpecCars < ActiveRecord::Migration[6.1]
  def change
    create_table :emm_spec_cars do |t|

      t.timestamps
    end
  end
end
