class CreateVulcanos < ActiveRecord::Migration[5.2]
  def change
    create_table :vulcanos do |t|

      t.timestamps
    end
  end
end
