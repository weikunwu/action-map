class AddCommentToRatings < ActiveRecord::Migration[5.2]
  def change
    add_column :ratings, :comment, :string
  end
end
