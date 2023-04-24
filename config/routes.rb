Rails.application.routes.draw do
  namespace :api do
    post 'add_note', action: :addNote, controller: :notes
    get 'get_noteById', action: :getNoteById, controller: :notes
    put 'update_note', action: :updateNote, controller: :notes
    delete 'delete_note', action: :deleteNote, controller: :notes
    get 'get_allNotes', action: :getAllNotes, controller: :notes
    get 'get_notesByTag', action: :getNoteByTag, controller: :notes
    get 'get_allNotesByUserId', action: :getNoteByIdUser, controller: :notes
    post 'add_user', action: :addUser, controller: :user
    get 'login', action: :login, controller: :user
    get 'get_allUsers', action: :getAllUsers, controller: :user
    put 'update_user', action: :updateUser, controller: :user
    get 'get_userById', action: :getUserById, controller: :user
    get 'get_userContaining', action: :getUsersContaining, controller: :user
    post 'create_friendshipRequest',  action: :createFriendshipRequest, controller: :user
    get 'get_friendshipsRequestsByUserId', action: :getFriendshipsRequestByUserId, controller: :user
    put 'accept_friendshipRequest', action: :acceptFriendshipRequest, controller: :user
    delete 'reject_friendshipRequest', action: :rejectFriendshipRequest, controller: :user
    get 'get_hasFriendshipRequest', action: :hasFriendshipRequest, controller: :user
    get 'get_FriendshipRequestOfUsers', action: :getFriendshipRequestOfUsers, controller: :user

  end
end
