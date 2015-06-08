class DropCommentIdFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :comment_id
  end
end
