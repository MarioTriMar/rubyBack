class Api::NotesController < ApplicationController
    def addNote
        note = Note.new(title: params[:title], text: params[:text], tag: params[:tag], idUser: params[:idUser], image: params[:image])
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
    def getNoteByIdUser
        note= Note.where(idUser: params[:idUser])
        if note
            render json:note, status: :ok
        else
            render json: {msg: 'Notes not found'}, status: :unprocessable_entity
        end
    end
    def updateNote
        note = Note.find(params[:_id])
        if note
            if note.update(title: params[:title], text: params[:text], tag: params[:tag], idUser: params[:idUser], image: params[:image])
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
    def getNoteByTag
        note= Note.where(tag: params[:tag])
        if note
            render json:note, status: :ok
        else
            render json: {msg: 'Note not found'}, status: :unprocessable_entity
        end
    end

    def createNoteRequest
        exist = SharedNote.where(userId: params[:userId], noteId: params[:noteId])
        
        if exist.present?
            render json:{message:"Already shared"}, status: :unprocessable_entity and return
        else
            sharedNote = SharedNote.new(userId: params[:userId], noteId: params[:noteId], state: params[:state])
            if sharedNote.save()
              render json:sharedNote, status: :ok
            else
                render json: {message: "Request not created"}, status: :unprocessable_entity
            end
        end
    end

    def getNoteRequests
        notesRequests= SharedNote.where(userId: params[:userId], state: 'false')
        requestsAux=[]
        notesRequests.each do |request|
            note=Note.find(request.noteId)
            requestsAux<<{
                noteRequest:request,
                note: note
            }
        end
        if requestsAux
            render json:requestsAux, status: :ok
        else
            render json: {msg: 'Requests not found'}, status: :unprocessable_entity
        end
    end
    def acceptRequest
        noteRequest=SharedNote.find(params[:requestId])
        if noteRequest
            if noteRequest.update(state:'true')
                render json:noteRequest, status: :ok
            else
                render json: {message: "Request not accepted"}, status: :unprocessable_entity
            end
        else
            render json: {message: "Request not found"}, status: :unprocessable_entity
        end
    end
    def rejectRequest
        noteRequest=SharedNote.find(params[:requestId])
        if noteRequest
            if noteRequest.destroy()
                render json:noteRequest, status: :ok
            else
                render json: {message: "Request not deleted"}, status: :unprocessable_entity
            end
        else
            render json: {message: "Request not found"}, status: :unprocessable_entity
        end
    end
end
