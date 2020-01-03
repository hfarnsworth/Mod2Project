class CreateOperations < ActiveRecord::Migration[6.0]
  def change
    create_table :operations do |t|
      t.integer :team_id
      t.integer :mission_id
    end
  end
end
