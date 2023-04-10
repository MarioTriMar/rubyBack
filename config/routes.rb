Rails.application.routes.draw do
  namespace :api do
    post 'add_note', action: :addNote, controller: :notes
    get 'get_noteById', action: :getNoteById, controller: :notes
    put 'update_note', action: :updateNote, controller: :notes
    delete 'delete_note', action: :deleteNote, controller: :notes
    get 'get_allNotes', action: :getAllNotes, controller: :notes
    get 'get_notesByTag', action: :getNoteByTag, controller: :notes
    post 'add_user', action: :addUser, controller: :user
    get 'login', action: :login, controller: :user
  end
end
