class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.string :desc , comment: '评分理由'
      t.decimal :score , comment: '评分'

      t.integer :line_id
      t.integer :user_id

      t.integer :like_people_count, comment: '点赞人数'
      t.integer :hate_people_count, comment: '点踩人数'

      t.timestamps
    end
  end
end
