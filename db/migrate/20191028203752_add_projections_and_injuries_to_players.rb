class AddProjectionsAndInjuriesToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :projection_week, :integer, default: 0
    add_column :players, :current_projection, :float, default: 0
    add_column :players, :injury_status, :string
  end
end
