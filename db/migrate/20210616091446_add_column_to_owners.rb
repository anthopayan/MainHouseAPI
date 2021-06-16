class AddColumnToOwners < ActiveRecord::Migration[6.1]
   def change
    create_table :add_column_to_owners do |t|
      add_reference :owners, :agency
      add_reference :owners, :building
      add_column :owners, :first_name, :string
      add_column :owners, :last_name, :string
      add_column :owners, :phone_number, :string
      add_column :owners, :lot, :string
      add_column :owners, :flat_number, :string
      add_column :owners, :owner_pic_profil, :text
      t.timestamps
    end
  end
end
