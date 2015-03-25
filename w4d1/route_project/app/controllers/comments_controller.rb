class CommentsController < ApplicationController
  def index
    render json: find_commentable.comments
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end

    nil
  end

  def comment_params
    params[:comment].permit(:commentable_id, :commentable_type, :body)
  end

end
