class AddTimestampsToQuestions < ActiveRecord::Migration
  def change
    change_table :questions do |t|
      t.timestamps null: false
    end

    reversible do |dir|
      dir.down do
        remove_column :questions, :updated_at
        remove_column :questions, :created_at
      end
    end
  end
end
