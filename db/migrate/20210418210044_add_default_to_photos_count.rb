class AddDefaultToPhotosCount < ActiveRecord::Migration[6.1]
  def change
    change_column_default(
      :users,
      :photos_count,
      0
    )
  end
end
