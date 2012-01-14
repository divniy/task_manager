class CommentsController < ApplicationController

  def create
    @story = Story.find(params[:story_id])
    @comment = @story.comments.build(params[:comment])
    if @comment.save
      redirect_to @story
    else
      @comments = []
      render 'stories/show'
    end
  end

  def destroy
    #TODO
  end

end
