# This will guess the User class
FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name } 
    lastname { Faker::Name.last_name }
    email { Faker::Internet.free_email("#{firstname} #{lastname}" ) }
    password "catcatcat" 
    password_confirmation "catcatcat"
    evernote_auth {"asdf#{rand(100)}" }
  end

  factory :notebook_and_user, class: Notebook do
    user
    guid {"asdf#{rand(100)}" }
    title {"notebook title: #{rand(100)}" }
    update_sequence_number {rand(100)}
  end

  factory :notebook do
    user { User.offset(rand(User.count)).first || create(:user) }
    guid {"asdf#{rand(100)}" }
    title { Faker::Lorem.words(rand(3)+1).join(' ') }
    update_sequence_number {rand(100)}
  end

  factory :note_with_user_and_notebook, class: Note do
    title { "notetitle: " + rand(1000).to_s }
    guid { "afsd" + rand(100000).to_s }
    user
    notebook
    notebook_guid 'asdfnl23' 
    update_sequence_number { rand(1000) }
    public false
  end

  factory :note do
    title { "notetitle: " + rand(1000).to_s }
    guid { "afsd" + rand(100000).to_s }
    user { User.offset(rand(User.count)).first || create(:user) }
    notebook { user.notebooks.empty? ? create(:notebook, user: user) : user.notebooks.sample }
    # User.joins(:notebooks).take(1)   --> gets a random user with a notebook
    notebook_guid { notebook.guid }
    update_sequence_number { rand(1000) }
    public false    
  end

  factory :question do 
    user  { User.offset(rand(User.count)).first || create(:user) }
    note { user.notes.empty? ? create(:note, user: user) : user.notes.sample }
    text { 'question text' + rand(100).to_s }
  end

  factory :answer do 
    user  { User.offset(rand(User.count)).first || create(:user) }
    note_id { user.notes.empty? ? create(:note, user: user) : user.notes.sample.id }
    question { note.questions.empty? ? create(:question, note: note) : note.questions.sample }
    text { 'answer text' + rand(100).to_s }
  end
  # create_table "answers", force: :cascade do |t|
  #   t.integer  "note_id"
  #   t.integer  "subject_id"
  #   t.integer  "user_id"
  #   t.integer  "question_id"
  #   t.string   "text"
  #   t.datetime "created_at",  null: false
  #   t.datetime "updated_at",  null: false
  #   t.integer  "quiz_id"
  # end


  # factory :question_with_note_notebook_and_user, class: Question do
  #   note  :note_with_user_and_notebook
  #   user  { note.user }
  #   text { 'text' + rand(100).to_s }
  # end


  # create_table "questions", force: :cascade do |t|
  #   t.integer  "note_id"
  #   t.string   "text"
  #   t.integer  "subject_id"
  #   t.integer  "user_id"
  #   t.integer  "answer_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end


  # This will use the User class (Admin would have been guessed)
  # factory :admin, class: User do
  #   first_name "Admin"
  #   last_name  "User"
  #   admin      true
  # end
end