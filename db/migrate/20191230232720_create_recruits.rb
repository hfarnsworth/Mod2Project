class CreateRecruits < ActiveRecord::Migration[6.0]
  def change
    create_table :recruits do |t|
      t.integer :superhero_id
      t.integer :team_id
    end
  end
end
