class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /notes
  # GET /notes.json
  def index

    @note = Note.new
    @notes = Note.all

    @label = Label.new
    @labels = Label.all.order(:created_at)

    @commenter = Commenter.new
    
    #@q = params[:q]

    #@ne = Note.where(:title => @q)

    @idsNotesMarcados = []

    @labels.each do |label|
      nameParLabel = "label"+label.id.to_s
      idLabel = params[nameParLabel]

      if !idLabel.nil?
        @idsNotesMarcados << idLabel
      end
    end

    if @idsNotesMarcados.length == 0

      @notesToDo = Note.where("done = 'false'").order(:updated_at)
      @notesLabelsToDo = @notesToDo.select("notes.id, labels.id, color").joins(:label).order("notes.updated_at")

      @notesDone = Note.where("done = 'true'").order(:updated_at)
      @notesLabelsDone = @notesDone.select("notes.id, labels.id, color").joins(:label).order("notes.updated_at")
      
    else
      labelsMarcados = Note.where(:label_id => @idsNotesMarcados)

      @notesToDo = labelsMarcados.where("done='false'").order(:updated_at)
      @notesLabelsToDo = @notesToDo.select("notes.id, labels.id, color").joins(:label).order("notes.updated_at")

      @notesDone = labelsMarcados.where("done='true'").order(:updated_at)
      @notesLabelsDone = @notesDone.select("notes.id, labels.id, color").joins(:label).order("notes.updated_at")
    end
  end

  # GET /notes/1
  def show    
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.done = false    
    
    @labels = Label.all.order(:created_at)

    @notesToDo = Note.where("done = 'false'").order(:updated_at)
    @notesDone = Note.where("done = 'true'").order(:updated_at)

    respond_to do |format|
      if @note.save
        format.html { redirect_to notes_path}
        format.json { render :show, status: :created, location: notes_path }
      else
        format.html { render :index, notice: "A" }
        #format.html { redirect_to root_path, notice: 'Error: Nota debe tener un título.' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    
    @labels = Label.all.order(:created_at)    
    @notesToDo = Note.where("done = 'false'").order(:updated_at)
    @notesDone = Note.where("done = 'true'").order(:updated_at)

    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to notes_path, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :index }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :done, :label_id)
    end
end
