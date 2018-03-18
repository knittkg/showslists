class ShowslistsController < ApplicationController
  before_action :set_showslist, only: [:show, :edit, :update, :destroy]
  before_action :set_current_user, only: [:new, :edit, :show , :destroy]

  # GET /showslists
  # GET /showslists.json
  def index
    #@showslists = Showslist.all
    #@showslists = Showslist.find(:all, :order => "live_date DESC")
    @showslists = Showslist.order(live_date: :DESC)
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
    # filepath = @upload_file.filename.url
    data =open(URI.encode( @upload_file.filename.url ))
    dlname = "#{@upload_file.live_date}_#{@upload_file.live_pref}_#{@upload_file.live_place}.mp3"
    # stat = File::stat(filepath)
    # open( filepath ) 
    # send_file(filepath, :filename => @upload_file.filename.url.gsub(/.*\//,''), :length => stat.size)
    # see https://stackoverflow.com/questions/12277971/using-send-file-to-download-a-file-from-amazon-s3
    # send_file(filepath, :filename => @upload_file.filename.url.gsub(/.*\//,''))
    # send_data(File.read(filepath), :filename => @upload_file.filename.url.gsub(/.*\//,''), :length => stat.size )
    # send_data data.read, disposition: 'attachment', filename: @upload_file.title , type: 'audio/mpeg' 
    send_data data.read, disposition: 'attachment', filename: dlname, type: 'audio/mpeg'
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
    
    def set_current_user
      unless logged_in?
      flash[:warning] = 'ログインして下さい'
      redirect_to new_session_path
      end
    end
end
