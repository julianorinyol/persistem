class AddTimestampsToAnswersAndQuestions < ActiveRecord::Migration
  def change
    change_table :answers do |t|

      t.timestamps null: false
    end

    reversible do |dir|
      dir.down do
        remove_column :answers, :updated_at
        remove_column :answers, :created_at
      end
    end

  end
end
