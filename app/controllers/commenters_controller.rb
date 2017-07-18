class CommentersController < ApplicationController
  before_action :set_commenter, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /commenters
  # GET /commenters.json
  def index
    @commenters = Commenter.where(:note_id => params[:note_id])
    @note = Note.find(params[:note_id])
  end

  # GET /commenters/1
  # GET /commenters/1.json
  def show
  end

  # GET /commenters/new
  def new
    @commenter = Commenter.new
    @note = Note.find(params[:note_id])
  end

  # GET /commenters/1/edit
  def edit
  end

  # POST /commenters
  # POST /commenters.json
  def create
    
    @note = Note.find(params[:note_id])
    @note_id = @note.id
    @commenter = @note.commenters.create(commenter_params)
    
    respond_to do |format|
      if @commenter.save
        format.html { redirect_to note_path(@note), notice: 'Commenter was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @commenter }
      else
        format.html { render :new }
        format.json { render json: @commenter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commenters/1
  # PATCH/PUT /commenters/1.json
  def update
    puts "UPDATE"
    @comment_id = params[:id]    
    @commenter = Commenter.find(params[:id])
    @note_id = @commenter.note_id
    puts @note_id
    @note = Note.find(@note_id)
    puts @note

    respond_to do |format|
      if @commenter.update(commenter_params)
        format.html { redirect_to notes_path, notice: 'Commenter was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @commenter }
      else
        format.html { render :edit }
        format.json { render json: @commenter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commenters/1
  # DELETE /commenters/1.json
  def destroy
    @commenter.destroy
    respond_to do |format|
      format.html { redirect_to commenters_url, notice: 'Commenter was successfully destroyed.' }
      format.js
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commenter
      @commenter = Commenter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commenter_params
      params.require(:commenter).permit(:message)
    end
end
