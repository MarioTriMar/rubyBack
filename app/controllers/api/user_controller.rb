class Api::UserController < ApplicationController
    def addUser
        if(params[:password] == params[:password2])
                if params[:password].match?(/^(?=.*\d)(?=.*[a-zA-Z]).{8,}$/)
                    if params[:phone].match?(/\A([6-9]\d{8})\z/)
                        user = User.new(username: params[:username], email: params[:email], phone: params[:phone], type: params[:type], password_digest: params[:password])
                        user.password_digest = BCrypt::Password.create(user.password_digest)
                        if user.save()
                            render json:user, status: :ok
                        else
                            render json: {message: "User not added"}, status: :unprocessable_entity
                        end
                    else
                        render json: {message: "The phone number must be between 600 00 00 00 and 999 99 99 99"}, status: :unprocessable_entity
                    end
                else
                    render json: {message: "The password must be at least 8 characters and at least one of them must be a digit"}, status: :unprocessable_entity
                end
        else
            render json: {message: "Passwords do not match"}, status: :unprocessable_entity
        end
        
    end
    def login
        user= User.find_by(email: params[:email])
        if user
            if user.authenticate(params[:password])
                render json:user, status: :ok
            else
                render json: {msg: 'Password is incorrect'}, status: :unprocessable_entity
            end
        else
            render json: {msg: 'User does not exist'}, status: :unprocessable_entity
        end
    end
    def getAllUsers
        user= User.where(type:'user')
        if user
            render json:user, status: :ok
        else
            render json: {msg: 'Note not found'}, status: :unprocessable_entity
        end
    end
    def updateUser
        
        if params[:phone].match?(/\A([6-9]\d{8})\z/)
            user = User.find(params[:_id])
            if user.username!=params[:username]
                Note.where(idUser: user.username).update_all(idUser: params[:username])
            end
            puts params[:username]
            User.find(params[:_id]).update(username: params[:username], email: params[:email], phone: params[:phone], type: params[:type])
            
        else
            render json: {message: "The phone number must be between 600 00 00 00 and 999 99 99 99"}, status: :unprocessable_entity
        end
    end
    def getUserById
        user= User.find(params[:_id])
        if user
            render json:user, status: :ok
        else
            render json: {msg: 'User not found'}, status: :unprocessable_entity
        end
    end

    def getUsersContaining
        search_term = params[:username]
        users=User.all
        matching_users = []
        users.each do |user|
            if user.username.downcase.include?(search_term.downcase)
                matching_users << user
            end
        end
        if matching_users
            render json:matching_users, status: :ok
        else
            render json: {msg: 'User not found'}, status: :unprocessable_entity
        end
    end

    def createFriendshipRequest
        friendship = Friendship.new(userA: params[:userA], userB: params[:userB], state: params[:state])
        if friendship.save()
            render json:friendship, status: :ok
        else
            render json: {message: "Friendship not created"}, status: :unprocessable_entity
        end
    end
    def getFriendshipsRequestByUserId
        friendships= Friendship.where(userB: params[:userB], state: 'false')
        friendshipsAux=[]
        friendships.each do |friendship|
            user=User.find(friendship.userA)
            friendshipsAux<<{
                _id:friendship._id,
                userA:friendship.userA,
                userB:friendship.userB,
                nameB:user.username,
                state:friendship.state,
                created_at:friendship.created_at,
                updated_at:friendship.updated_at
            }
        end
        if friendshipsAux
            render json:friendshipsAux, status: :ok
        else
            render json: {msg: 'Requests not found'}, status: :unprocessable_entity
        end
    end
    def acceptFriendshipRequest
        friendship = Friendship.find(params[:_id])
        if friendship
            if friendship.update(state:'true')
                render json:friendship, status: :ok
            else
                render json: {message: "Request not updated"}, status: :unprocessable_entity
            end
        else
            render json: {message: "Request not found"}, status: :unprocessable_entity
        end
    end

    def rejectFriendshipRequest
        friendship = Friendship.find(params[:_id])
        if friendship
            if friendship.destroy
                render json:{message: "Request deleted"}, status: :ok
            else
                render json: {message: "Request not deleted"}, status: :unprocessable_entity
            end
        else
            render json: {message: "Request not found"}, status: :unprocessable_entity
        end
    end
    def hasFriendshipRequest
        friendshipA = Friendship.where(userA: params[:userA], userB: params[:userB], state: 'false')
        if friendshipA.present?
            render json:{message:"alreadySent"}, status: :ok and return 
        end
        friendshipB = Friendship.where(userA: params[:userB], userB: params[:userA], state:'false')
        if friendshipB.present?
            render json:{message:"applicant"}, status: :ok and return 
        end
        friendshipAtrue = Friendship.where(userA: params[:userA], userB: params[:userB], state: 'true')
        if friendshipAtrue.present?
            render json:{message:"friends"}, status: :ok and return 
        end
        friendshipBtrue = Friendship.where(userA: params[:userB], userB: params[:userA], state:'true')
        if friendshipBtrue.present?
            render json:{message:"friends"}, status: :ok and return 
        end
    end
    def getFriendshipRequestOfUsers
        friendship=Friendship.where(userA: params[:userB], userB: params[:userA], state:'false')
        if friendship
            render json:friendship, status: :ok
        else
            render json: {msg: 'Friendship not found'}, status: :unprocessable_entity
        end
    end
end
