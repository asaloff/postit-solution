class ChangeVoteColumnName < ActiveRecord::Migration
  def change
    rename_column :votes, :votes, :vote
    add_column(:votes, :created_at, :datetime)
    add_column(:votes, :updated_at, :datetime)
  end
end
