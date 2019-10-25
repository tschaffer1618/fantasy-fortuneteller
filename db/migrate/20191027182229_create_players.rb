class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :active
      t.string :jersey
      t.string :lname
      t.string :fname
      t.string :display_name
      t.string :team
      t.string :position
      t.string :height
      t.string :weight
      t.string :college
      t.string :experience
      t.string :birth_date
      t.string :photo_url
      t.string :bye_week
      t.string :ffn_id
      t.string :ffn_id 

    end
  end
end
