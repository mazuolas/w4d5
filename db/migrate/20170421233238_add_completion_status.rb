class AddCompletionStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :goals, :status, :boolean, default: false
  end
end
