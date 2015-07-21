class AddSubjectIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :subject_id, :integer
    add_column :notes, :title, :string

    create_table :questions do |t|
      t.integer :note_id
      t.string :text
      t.integer :subject_id
      t.integer :user_id
      t.integer :answer_id
    end
    
    create_table :answers do |t|
      t.integer :note_id
      t.integer :subject_id
      t.integer :user_id
      t.integer :question_id
      t.string :text
    end

    create_table :meta_tags do |t|
      t.integer :note_id
      t.integer :user_id
      t.string :subject
      t.string :text_qualifier
      t.integer :number_quantifier
      t.boolean :boolean_qualifier
    end
  end
end
