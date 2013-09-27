class VaggasController < ApplicationController
  before_action :set_vagga, only: [:show, :edit, :update, :destroy]

  # GET /vaggas
  # GET /vaggas.json
  def index
    @vaggas = Vagga.all
  end

  # GET /vaggas/1
  # GET /vaggas/1.json
  def show
  end

  # GET /vaggas/new
  def new
    @vagga = Vagga.new
  end

  # GET /vaggas/1/edit
  def edit
  end

  # POST /vaggas
  # POST /vaggas.json
  def create
    @vagga = Vagga.new(vagga_params)

    respond_to do |format|
      if @vagga.save
        format.html { redirect_to @vagga, notice: 'Vagga was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vagga }
      else
        format.html { render action: 'new' }
        format.json { render json: @vagga.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vaggas/1
  # PATCH/PUT /vaggas/1.json
  def update
    respond_to do |format|
      if @vagga.update(vagga_params)
        format.html { redirect_to @vagga, notice: 'Vagga was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vagga.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vaggas/1
  # DELETE /vaggas/1.json
  def destroy
    @vagga.destroy
    respond_to do |format|
      format.html { redirect_to vaggas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vagga
      @vagga = Vagga.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vagga_params
      params.require(:vagga).permit(:index, :book_id)
    end
end
