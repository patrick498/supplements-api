class CreateIntakes < ActiveRecord::Migration[8.0]
  def change
    create_table :intakes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :supplement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
