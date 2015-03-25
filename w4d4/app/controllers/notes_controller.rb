class NotesController < ApplicationController


  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id

    if @note.save
      redirect_to track_url(@note.track_id)
    else
      redirect_to track_url(@note.track_id)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    track = Track.find(@note.track_id)
    if current_user.id == @note.user_id && @note.destroy
      #message
      redirect_to track_url(track)
    else
      #error
      redirect_to track_url(track)
    end
  end

  private
  def note_params
    params.require(:note).permit(:comment, :user_id, :track_id)
  end


end
