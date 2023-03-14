class Api::NotesController < ApplicationController
    def addNote
        note = Note.new(title: params[:title], text: params[:text], tag: params[:tag], idUser: params[:idUser])
        if note.save()
            render json:note, status: :ok
        else
            render json: {message: "Note not added"}, status: :unprocessable_entity
        end
    end
    def getNoteById
        note= Note.find(params[:_id])
        if note
            render json:note, status: :ok
        else
            render json: {msg: 'Note not found'}, status: :unprocessable_entity
        end
    end
    def updateNote
        note = Note.find(params[:_id])
        if note
            if note.update(title: params[:title], text: params[:text], tag: params[:tag], idUser: params[:idUser])
                render json:note, status: :ok
            else
                render json: {message: "Note not updated"}, status: :unprocessable_entity
            end
        else
            render json: {message: "Note not found"}, status: :unprocessable_entity
        end
    end

    def deleteNote
        note = Note.find(params[:_id])
        if note
            if note.destroy()
                render json:note, status: :ok
            else
                render json: {message: "Note not deleted"}, status: :unprocessable_entity
            end
        else
            render json: {message: "Note not found"}, status: :unprocessable_entity
        end
    end
    def getAllNotes
        
        note = Note.all
        
        if note
            render json:note, status: :ok
        else
            render json: {message: "Notes not found"}, status: :unprocessable_entity
        end
    end
end