class StoriesController < ApplicationController
  # GET /stories
  def index
    @users = User.all
    @states = State.all
    @stories = Story.all
    if params[:by] == 'user' #and @users.collect{|u| u.id}.include?(params[:id].to_i)
      @stories = User.find(params[:id].to_i).stories
    elsif params[:by] == 'state' #and @stories.collect{|s| s.state.id}.include?(params[:id].to_i)
      @stories = Story.find_all_by_state(State.new(params[:id].to_i))
    else
      @stories = Story.all
    end
  end

  # GET /stories/1
  def show
    @story = Story.find(params[:id])
    @comments = @story.comments
    @comment = Comment.new
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /stories
  def create
    @story = Story.new(params[:story])
    if @story.save
      redirect_to @story, notice: 'Story was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /stories/1
  def update
    @story = Story.find(params[:id])
    if @story.update_attributes(params[:story])
      redirect_to @story, notice: 'Story was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /stories/1
  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to stories_url
  end
end
