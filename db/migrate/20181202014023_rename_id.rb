class RenameId < ActiveRecord::Migration[5.2]
  def change
    rename_column "open_airports", "id", "identif"
  end
end
