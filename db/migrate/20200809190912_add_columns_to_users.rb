class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :photo, :string

    add_reference :posts, :user, index: true
    add_reference :comments, :user, index: true

  end
end
