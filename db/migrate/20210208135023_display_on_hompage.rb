class DisplayOnHompage < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :display_home, :boolean, default: false
  end
end
