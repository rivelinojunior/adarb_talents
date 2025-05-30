class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :fullname, null: false
      t.string :current_role, null: false
      t.text :short_bio, null: false
      t.references :user, null: false, foreign_key: true
      t.json :links
      t.string :phone_number
      t.string :location
      t.json :skills, null: false
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
