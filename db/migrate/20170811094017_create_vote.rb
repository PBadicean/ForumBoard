class CreateVote < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :value
      t.belongs_to :user, foreign_key: true
      t.references :votable, polymorphic: true, index: true
    end
  end
end
