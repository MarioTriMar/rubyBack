Rails.application.routes.draw do
  namespace :api do
    post 'add_note', action: :addNote, controller: :notes
    get 'get_noteById', action: :getNoteById, controller: :notes
    put 'update_note', action: :updateNote, controller: :notes
    delete 'delete_note', action: :deleteNote, controller: :notes
  end
end
