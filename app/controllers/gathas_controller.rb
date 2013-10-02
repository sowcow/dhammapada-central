class GathasController < ApplicationController
  before_action :set_gatha, only: [:show, :edit, :update, :destroy]

  # GET /gathas
  # GET /gathas.json
  def index
    @gathas = Gatha.all
  end

  # GET /gathas/1
  # GET /gathas/1.json
  def show
    @excerpts = @gatha.translations.flat_map { |t|
      t.excerpts
    }
  end

  # GET /gathas/new
  def new
    @gatha = Gatha.new
  end

  # GET /gathas/1/edit
  def edit
  end

  # POST /gathas
  # POST /gathas.json
  def create
    @gatha = Gatha.new(gatha_params)

    respond_to do |format|
      if @gatha.save
        format.html { redirect_to @gatha, notice: 'Gatha was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gatha }
      else
        format.html { render action: 'new' }
        format.json { render json: @gatha.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gathas/1
  # PATCH/PUT /gathas/1.json
  def update
    respond_to do |format|
      if @gatha.update(gatha_params)
        format.html { redirect_to @gatha, notice: 'Gatha was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gatha.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gathas/1
  # DELETE /gathas/1.json
  def destroy
    @gatha.destroy
    respond_to do |format|
      format.html { redirect_to gathas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gatha
      @gatha = Gatha.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gatha_params
      params.require(:gatha).permit(:index, :vagga_id)
    end
end
