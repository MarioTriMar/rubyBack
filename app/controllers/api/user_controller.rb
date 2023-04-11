class Api::UserController < ApplicationController
    def addUser
        
        if(params[:password] == params[:password2])
                if params[:password].match?(/^(?=.*\d)(?=.*[a-zA-Z]).{8,}$/)
                    user = User.new(username: params[:username], email: params[:email], password_digest: params[:password])
                    user.password_digest = BCrypt::Password.create(user.password_digest)
                    if user.save()
                        render json:user, status: :ok
                    else
                        render json: {message: "User not added"}, status: :unprocessable_entity
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
end
