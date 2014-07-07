class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update]
  before_action :admin_user?, only: [:edit, :update]
  before_action :correct_or_admin_user?, only: [:show]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  # GET /players/new
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new
    @player.user = current_user
    @player.game = Game.last
    @player.faction = Player::HUMAN
    @player.score = 0
    @player.tag_code = Player.generate_code

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Successfully registered. Make sure you write down your tag code' }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:faction, :tag_code, :score)
    end
end
