class AddAuthTokenToUsers < ActiveRecord::Migration
  def change
      add_column :users, :evernote_auth, :string
  end
end
