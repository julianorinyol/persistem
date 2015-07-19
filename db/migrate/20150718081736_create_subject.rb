class CreateSubject < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.integer :note_id
      t.string :subject
    end

    add_column :notes, :content, :string
  end
end
