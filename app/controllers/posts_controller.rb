class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(params.permit(:category_id))
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new()
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to @post
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def search
    if params[:search_terms] != "" && params[:search_terms] != nil
      @posts = Array.new()
      Post.all.each do |pst|
        if pst.title.downcase.include?(params[:search_terms].downcase) || pst.body.downcase.include?(params[:search_terms].downcase)
          @posts.push pst
        end
      end
    else
      @posts = Post.all
      flash[:notice] = "No posts were found"
      render :index
    end
    
    if @posts == nil || @posts.empty?
      @posts = Post.all
      flash[:notice] = "No posts were found"
      render :index
    end
  end
  
  def flagpost
     @post = Post.find(params[:id])
    @post.flagpost=true
    @post.save
     flash[:success] = "post was flagged"
   redirect_to post_path id:@post.id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :thumbnail)
    end
end
