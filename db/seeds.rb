# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# User.create(name: "bigdog", email: "big@dog.com", password: "testes", password_confirmation: "testes")



if(User.all.length > 0)
  notes = Note.all
  user = User.first
    
  if(user)
    notes.each do |note|
      while note.questions.length < 5
        text = 'seed question' << note.questions.length.to_s << ' for note: ' << note.id.to_s

        note.questions << Question.create(text: text, user_id: user.id)
        puts 'seeded question ' << note.questions.length.to_s << ' for note: ' << note.id.to_s
      end
    end
    questions = Question.all
    
    questions.each do |question|
      while question.answers.length < 5 

        text = 'seed answer' << question.answers.length.to_s << ' for question: ' << question.id.to_s << ' note: ' << question.note_id.to_s

        question.answers << Answer.create(text: text, user_id: user.id )
        puts 'seeded answer' << question.answers.length.to_s << ' for question: ' << question.id.to_s
      end  #while
    end #questions.each
  end #if user

end # if User.all.length





=begin
  create_table "answers", force: :cascade do |t|
    t.integer  "note_id"
    t.integer  "subject_id"
    t.integer  "user_id"
    t.integer  "question_id"
    t.string   "text"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end


question
      t.integer  "note_id"
    t.string   "text"
    t.integer  "subject_id"
    t.integer  "user_id"
    t.integer  "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  
=end