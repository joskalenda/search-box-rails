class CachesController < ApplicationController
  before_action :set_cach, only: %i[show edit update destroy]

  # GET /caches or /caches.json
  def index
    @caches = Cach.all
  end

  # GET /caches/1 or /caches/1.json
  def show; end

  # GET /caches/new
  def new
    @cach = Cach.new
  end

  # GET /caches/1/edit
  def edit; end

  # POST /caches or /caches.json
  def create
    @cach = Cach.new(cach_params)

    respond_to do |format|
      if @cach.save
        format.html { redirect_to cach_url(@cach), notice: 'Cach was successfully created.' }
        format.json { render :show, status: :created, location: @cach }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cach.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /caches/1 or /caches/1.json
  def update
    respond_to do |format|
      if @cach.update(cach_params)
        format.html { redirect_to cach_url(@cach), notice: 'Cach was successfully updated.' }
        format.json { render :show, status: :ok, location: @cach }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cach.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /caches/1 or /caches/1.json
  def destroy
    @cach.destroy

    respond_to do |format|
      format.html { redirect_to caches_url, notice: 'Cach was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cach
    @cach = Cach.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cach_params
    params.fetch(:cach, {})
  end
end
