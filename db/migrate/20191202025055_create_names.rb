class CreateNames < ActiveRecord::Migration[5.2]
  def change
    create_table :names do |t|
      t.string :first_name
      t.string :last_name
      t.string :full_name

      t.timestamps
    end
  end
end
