class TagsController < ApplicationController
  before_action :set_tag, only: [:show]
  before_action :admin_user?, only: [:index, :show]

  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.all
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
    if !current_user
      flash[:error] = 'You must be signed in to submit a tag'
    end
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(tag_params)
    if current_user.admin? && params[:admin_tag]
      @tag.admin_tag = true
    else
      @tag.tagger = current_user.player
    end

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:tag_code, :time)
    end
end
