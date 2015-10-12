# This will guess the User class
FactoryGirl.define do
  
  factory :evernote_user, class: User do
    firstname { Faker::Name.first_name } 
    lastname { Faker::Name.last_name }
    email { Faker::Internet.free_email("#{firstname} #{lastname}" ) }
    password "password" 
    password_confirmation "password"
    evernote_auth ENV["TEST_AUTH_TOKEN"]
    last_usn { 0 }
  end
  
  factory :empty_user, class: User do
    firstname { Faker::Name.first_name } 
    lastname { Faker::Name.last_name }
    email { Faker::Internet.free_email("#{firstname} #{lastname}" ) }
    password "password" 
    password_confirmation "password"
    evernote_auth ENV["TEST_EMPTY_ACCOUNT_AUTH"]
    last_usn { 0 }
  end



  factory :user do
    firstname { Faker::Name.first_name } 
    lastname { Faker::Name.last_name }
    email { Faker::Internet.free_email("#{firstname} #{lastname}" ) }
    password "password" 
    password_confirmation "password"
    evernote_auth {"asdf#{rand(100)}" }
    last_usn { 0 }
  end

  factory :notebook do
    user { User.offset(rand(User.count)).first || create(:user) }
    guid {"asdf#{rand(100)}" }
    title { Faker::Lorem.words(rand(3)+1).join(' ') }
    sequence(:update_sequence_number) {|n| user.last_usn + 1000 +n }
  end

  factory :note do
    title { "notetitle: " + rand(1000).to_s }
    guid { "afsd" + rand(100000).to_s }
    user { User.offset(rand(User.count)).first || create(:user) }
    notebook { user.notebooks.empty? ? create(:notebook, user: user) : user.notebooks.sample }
    # User.joins(:notebooks).take(1)   --> gets a random user with a notebook
    notebook_guid { notebook.guid }
    sequence(:update_sequence_number) {|n| user.last_usn + n }
    public false    
  end

  factory :question do 
    user  { User.offset(rand(User.count)).first || create(:user) }
    note { user.notes.empty? ? create(:note, user: user) : user.notes.sample }
    text { 'question text' + rand(100).to_s }
  end

  factory :answer do 
    user  { User.offset(rand(User.count)).first || create(:user) }
    question { 
      note = (user.notes.empty? ? create(:note, user:user) : user.notes.sample) 
      note.questions.empty? ? create(:question, user: user) : note.questions.sample 
    }
    note_id { question.note.id }
    text { 'answer text' + rand(100).to_s }
  end
  factory :quiz do 
    user  { User.offset(rand(User.count)).first || create(:user) }
  end

  # This will use the User class (Admin would have been guessed)
  # factory :admin, class: User do
  #   first_name "Admin"
  #   last_name  "User"
  #   admin      true
  # end
end