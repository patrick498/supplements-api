class CreateSupplements < ActiveRecord::Migration[8.0]
  def change
    create_table :supplements do |t|
      t.string :name

      t.timestamps
    end
  end
end
