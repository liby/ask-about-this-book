class AddDefaultToAskCount < ActiveRecord::Migration[6.1]
  def change
    change_column_default :questions, :ask_count, 0
  end
end
