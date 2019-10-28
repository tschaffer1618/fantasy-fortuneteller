class AddProjectionsAndInjuriesToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :projection_week, :integer
    add_column :players, :current_projection, :float
    add_column :players, :injury_status, :string
  end
end
