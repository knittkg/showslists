class ShowslistsController < ApplicationController
  before_action :set_showslist, only: [:show, :edit, :update, :destroy]

  # GET /showslists
  # GET /showslists.json
  def index
    @showslists = Showslist.all
  end

  # GET /showslists/1
  # GET /showslists/1.json
  def show
  end

  # GET /showslists/new
  def new
    @showslist = Showslist.new
  end

  # GET /showslists/1/edit
  def edit
  end

  # POST /showslists
  # POST /showslists.json
  def create
    @showslist = Showslist.new(showslist_params)
    @showslist.save!

    respond_to do |format|
      if @showslist.save
        format.html { redirect_to @showslist, notice: 'Showslist was successfully created.' }
        format.json { render :show, status: :created, location: @showslist }
      else
        format.html { render :new }
        format.json { render json: @showslist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /showslists/1
  # PATCH/PUT /showslists/1.json
  def update
    respond_to do |format|
      if @showslist.update(showslist_params)
        format.html { redirect_to @showslist, notice: 'Showslist was successfully updated.' }
        format.json { render :show, status: :ok, location: @showslist }
      else
        format.html { render :edit }
        format.json { render json: @showslist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /showslists/1
  # DELETE /showslists/1.json
  def destroy
    @showslist.destroy
    respond_to do |format|
      format.html { redirect_to showslists_url, notice: 'Showslist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
    @upload_file = Showslist.find(params[:id].to_i)
    filepath = @upload_file.filename.current_path
    stat = File::stat(filepath)
    send_file(filepath, :filename => @upload_file.filename.url.gsub(/.*\//,''), :length => stat.size)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_showslist
      @showslist = Showslist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def showslist_params
      params.require(:showslist).permit(:live_date, :live_place, :live_pref, :last_modified, :filename, :name, :title, :length, :playtime)
    end
end
