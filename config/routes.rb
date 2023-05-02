Rails.application.routes.draw do
  namespace :api do
    post 'add_note', action: :addNote, controller: :notes
    get 'get_noteById', action: :getNoteById, controller: :notes
    put 'update_note', action: :updateNote, controller: :notes
    delete 'delete_note', action: :deleteNote, controller: :notes
    get 'get_allNotes', action: :getAllNotes, controller: :notes
    get 'get_notesByTag', action: :getNoteByTag, controller: :notes
    get 'get_allNotesByUserId', action: :getNoteByIdUser, controller: :notes
    delete 'delete_allNotesByUserId', action: :deleteNoteByIdUser, controller: :notes
    post 'add_user', action: :addUser, controller: :user
    delete 'delete_user', action: :deleteUser, controller: :user
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
    get 'get_allFriends', action: :getAllFriends, controller: :user
    post 'create_noteRequest', action: :createNoteRequest, controller: :notes
    get 'get_sharedNoteRequests', action: :getNoteRequests, controller: :notes
    put 'accept_noteRequest', action: :acceptRequest, controller: :notes
    delete 'reject_noteRequest', action: :rejectRequest, controller: :notes
    put 'update_password', action: :updatePassword, controller: :user
    post 'create_collection', action: :createCollection, controller: :notes
    put 'add_noteToCollection', action: :addNoteToCollection, controller: :notes
    get 'get_collectionsOfUser', action: :getCollectionsOfUser, controller: :notes
    delete 'delete_noteOfCollection', action: :deleteNoteOfCollection, controller: :notes
    delete 'delete_collection', action: :deleteCollection, controller: :notes
    get 'get_notesOfCollection', action: :getNotesOfCollection, controller: :notes
    get 'get_allFriendships', action: :getAllFriendships, controller: :user
    get 'get_AllNotesShared', action: :getAllNotesShared, controller: :notes
    get 'get_AllSharedNotesByUserId', action: :getAllSharedNotesByUserId, controller: :notes
    get 'get_allCollections', action: :getAllCollections, controller: :notes 
    get 'get_AllPossibleNotes', action: :getAllPossibleNotes, controller: :notes
    
  end
end
