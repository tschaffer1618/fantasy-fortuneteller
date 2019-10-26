class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.integer :active
      t.integer :jersey
      t.string :lname
      t.string :fname
      t.string :display_name
      t.string :team
      t.string :position
      t.boolean :benched?, default: true
      t.string :height
      t.integer :weight
      t.string :college
      t.string :experience
      t.string :birth_date
      t.string :photo_url
      t.integer :bye_week
      t.integer :ffn_id

    end
  end
end
