# This will guess the User class
FactoryGirl.define do
  factory :user do
    firstname "Donkey" 
    lastname "Anderson" 
    email { "#{firstname}.#{lastname}#{rand(1000)}@example.com".downcase }
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
    user_id { User.first.id }
    guid {"asdf#{rand(100)}" }
    title {"notebook title: #{rand(100)}" }
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
    user_id { User.first.id }
    notebook_id { 
      @this_notebook = User.first.notebooks.first.id
    }
    # User.joins(:notebooks).take(1)   --> gets a random user with a notebook
    notebook_guid { User.first.notebooks.first.guid }
    update_sequence_number { rand(1000) }
    public false    
  end

   # Note.new(
   #    title: 'bla',
   #    guid: 'asdf23', 
   #    user_id: @user.id, 
   #    notebook_guid: @notebook.guid, 
   #    notebook_id: @notebook.id, 
   #    update_sequence_number: 14, 
   #    public: false
   #  )

  # This will use the User class (Admin would have been guessed)
  # factory :admin, class: User do
  #   first_name "Admin"
  #   last_name  "User"
  #   admin      true
  # end
end