class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :text, :text_post]
  before_action :admin_user?, only: [:new, :create, :edit, :update, :text, :text_post]

  def text
  end

  def text_post
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token
    players = Player.includes(:user)
    if params[:faction_id].present?
      players = players.where(faction: params[:faction_id])
    end
    players.each do |player|
      if player.user.phone_number.present?
        @client.account.messages.create(from: '+14158057526', to: player.user.phone_number, body: params[:message])
      end
    end
    binding.pry
    redirect_to text_game_path(@game.id)
  end

  def emails
    @game = Game.find(params[:id])
    @players = @game.players.includes(:user)
    if params[:faction].present?
      @players = @players.where(faction: params[:faction])
    end
  end

  # GET /games
  # GET /games.json
  def index
    if Game.last
      redirect_to Game.last
    else
      render text: "Make a game!"
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @players = @game.players.order(score: :desc)
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:start_time, :end_time)
    end
end
