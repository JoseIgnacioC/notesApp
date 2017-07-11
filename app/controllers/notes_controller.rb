class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /notes
  # GET /notes.json
  def index
    
    #Preparacion de labels
    @label = Label.new
    @labels = Label.where(:user_id => current_user.id).order(:created_at)
    
    #Crear label de sin etiqueta a cada usuario
    if @labels[0].nil?
      newLabel = Label.new(:title => '00SINETIQUETAR00',:color => 'transparent', :user_id => current_user.id)
      newLabel.save
      #Considerar label por default
      @labels = Label.where(:user_id => current_user.id).order(:created_at)
    end

    #Arreglo con los ids de los labels del usuario actual
    arrayIdsLabels = []
    @labels.each do |label|
      arrayIdsLabels << label.id
    end

    #Preparacion de notes
    @note = Note.new
    @notes = Note.where(:label_id => arrayIdsLabels)    

    #Preparacion de comentarios
    @commenter = Commenter.new
    
    #Preparacion de notas a mostrar en index
    ##Saber que labels estan marcados
    @idsLabelsMarcados = []

    @labels.each do |label|
      nameParLabel = "label"+label.id.to_s
      idLabel = params[nameParLabel]

      if !idLabel.nil?
        @idsLabelsMarcados << idLabel
      end
    end

    # Si no hay labels marcados, mostrar todas las notas
    if @idsLabelsMarcados.length == 0

      @notesToDo = @notes.where("done = 'false'").order(:updated_at)      
      #@notesLabelsToDo = @notesToDo.select("notes.id, notes.title, done, labels.id, color").joins(:label).order("notes.updated_at")

      @notesDone = @notes.where("done = 'true'").order(:updated_at)
      #@notesLabelsDone = @notesDone.select("notes.id, labels.id, labels.title, color").joins(:label).order("notes.updated_at")

    ## Sino mostrar solo las notas de los labels marcados
    else
      labelsMarcados = @notes.where(:label_id => @idsLabelsMarcados)

      @notesToDo = labelsMarcados.where("done='false'").order(:updated_at)
      #@notesLabelsToDo = @notesToDo.select("notes.id, labels.id, labels.title, color").joins(:label).order("notes.updated_at")

      @notesDone = labelsMarcados.where("done='true'").order(:updated_at)
      #@notesLabelsDone = @notesDone.select("notes.id, labels.id, labels.title, color").joins(:label).order("notes.updated_at")
    end
  end

  # GET /notes/1
  def show

    @note = Note.find(params[:id])
    @labels = Label.where(:user_id => current_user.id).order(:created_at)

    @noteLabel = @labels.where(:id => @note.label_id)
    

    if @noteLabel[0].nil?
      @permitUser = false
    else
      @permitUser = true
    end
  end

  #GET /notes/:id/edit
  def edit
    @labels = Label.where(:user_id => current_user.id).order(:created_at)    
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @note.done = false    
    
    #@labels = Label.where(:user_id => current_user.id).order(:created_at)    
    #@notes = Note.where(:label_id => @arrayIdsLabels)
  
    #Si al crear no se le asigno un label -> Label por default
    if @note.label_id.nil?
      labelNull = Label.where(:title => "00SINETIQUETAR00", :user_id => current_user.id)
      @note.label_id = labelNull[0].id
    end

    #@notesToDo = @notes.where("done = 'false'").order(:updated_at)
    #@notesDone = @notes.where("done = 'true'").order(:updated_at)

    respond_to do |format|
      if @note.save
        format.html { redirect_to notes_path}
        format.js
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
    
    #@labels = Label.where(:user_id => current_user.id).order(:created_at)
    #@notes = @labels.select('notes.id, labels.id, labels.title, done, color').joins(:notes).order("notes.updated_at")
    #@notes = Note.where(:label_id => @arrayIdsLabels)

    #@notesToDo = @notes.where("done = 'false'").order(:updated_at)
    #@notesDone = @notes.where("done = 'true'").order(:updated_at)

    puts "UPDATE"

    respond_to do |format|
      
      if @note.update(note_params)
        format.html { redirect_to notes_path, notice: 'Note was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @note }
        
      else
        format.html { render :index }        
        format.js
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
      format.js   { render :layout => false }
    end
  end

  def filter_labels
    arrayL = params[:arrayL]
    notes = Note.select("id").where(:label_id => arrayL)    

    render :json =>  notes
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
