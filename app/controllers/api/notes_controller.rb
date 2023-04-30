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
    def deleteNoteByIdUser
        if Note.where(idUser: params[:idUser]).destroy_all
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
                shared=SharedNote.where(noteId: note._id)
                if shared
                    shared.destroy_all
                end
                collections=Collection.all
                if collections
                    collections.each do |collection|
                        collection.notes.delete(params[:_id])
                        collection.update()
                    end
                end

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
    def getAllSharedNotesByUserId
        request=SharedNote.where(userId: params[:userId], state:'true')
        notes=[]
        if request
            request.each do |req|
                note=Note.find(req.noteId)
                notes<<note
            end
            if notes
                render json:notes, status: :ok
            else
                render json: {message: "Notes not found"}, status: :unprocessable_entity
            end
        else
            render json: {message: "Requests not found"}, status: :unprocessable_entity
        end
    end
    def getNoteRequests
        notesUser=Note.where(idUser: params[:userId])
        sharedRequest=[]
        if notesUser
            notesUser.each do |note|
                request=SharedNote.where(noteId: note._id, state:'false')
                request.each do |req|
                    user=User.find(req.userId)
                    sharedRequest<<{
                        request:req,
                        note: note,
                        user: user
                    
                    }
                end
                
            end
            if sharedRequest
                render json:sharedRequest, status: :ok
            else
                render json: {message: "Not requests available"}, status: :unprocessable_entity
            end
        else
            render json: {message: "Notes not found"}, status: :unprocessable_entity
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

    def createCollection
        collection = Collection.new(name: params[:name], idUser: params[:idUser])
        if collection.save()
            render json:collection, status: :ok
        else
            render json: {message: "Collection not created"}, status: :unprocessable_entity
        end
    end
    def addNoteToCollection
        collection=Collection.find(_id:params[:collectionId])
        if collection.notes.include?(params[:noteId])
            render json: {message: "The note is already in the collection"}, status: :unprocessable_entity
        else
            collection.notes<<params[:noteId]
            if collection.update()
                render json:collection, status: :ok
            else
                render json: {message: "Note not added"}, status: :unprocessable_entity
            end
        end
        
    end
    def getCollectionsOfUser
        collection=Collection.where(idUser:params[:idUser])
        if collection
            render json:collection, status: :ok
        else
            render json: {message: "Collections not found"}, status: :unprocessable_entity
        end
    end
    def deleteNoteOfCollection
        collection=Collection.find(_id:params[:collectionId])
        collection.notes.delete(params[:noteId])
        if collection.update()
            render json:collection, status: :ok
        else
            render json: {message: "Note not added"}, status: :unprocessable_entity
        end
    end
    def deleteCollection
        collection = Collection.find(params[:collectionId])
        if collection
            if collection.destroy()
                render json:collection, status: :ok
            else
                render json: {message: "Collection not deleted"}, status: :unprocessable_entity
            end
        else
            render json: {message: "Collection not found"}, status: :unprocessable_entity
        end
    end
    def getNotesOfCollection
        collection=Collection.find(params[:collectionId])
        notes=[]
        if collection
            notesId=collection.notes
            notesId.each do |id|
                note=Note.find(id)
                notes<<note
            end
            render json:notes, status: :ok
        else
            render json: {message: "Collection not found"}, status: :unprocessable_entity
        end
    end
    def getAllNotesShared
        sharedNotes=[]
        requests=SharedNote.where(state:'true')
        requests.each do |request|
            note=Note.find(request.noteId)
            
            user=User.find(request.userId)
            sharedNotes<<{
                idShared: request._id,
                note:note,
                user: user.username
            }         
        end
        if sharedNotes
            render json:sharedNotes, status: :ok
        else
            render json: {message: "Shared notes not found"}, status: :unprocessable_entity
        end
    end
    def getAllCollections
        
        collections = Collection.all
        
        if collections
            render json:collections, status: :ok
        else
            render json: {message: "Collections not found"}, status: :unprocessable_entity
        end
    end
end
