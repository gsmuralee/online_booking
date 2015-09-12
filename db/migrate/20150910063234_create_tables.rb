class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
