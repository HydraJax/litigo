class DocumentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  # GET /documents
  # GET /documents.json
  def index
    if get_case
      @documents = @case.documents
      @new_path_documents = new_case_document_path(@case)
      @documents_a = [@case, Document.new] #for modal partial rendering
    else
      @documents = @user.documents
      @new_path_documents = new_document_path
      @documents_a = Document.new #for modal partial rendering
    end

    if params[:order] && ["asc", "desc"].include?(params[:sort_mode])
      order = params[:order].split(",").map {|o| "#{o} #{params[:sort_mode]}" }.join(", ")
      if params[:order] =='cases'
        @documents = @documents.eager_load(params[:order].to_sym).order(order)
      else
        @documents = @documents.order(order)
      end
    end
    if params[:search].present? && params[:utf8] == "✓"
      logger.info"#{params[:search]}"
      @documents = @documents.search(params[:search])

    end
    @documents = @documents.paginate(:per_page => 10, :page => params[:page])

  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  
  end

  # POST /documents
  # POST /documents.json
  def create
    if get_case
      @document = @case.documents.create(document_params)
    else
      @document = Document.new(document_params)
    end

    @document.user = @user

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:author, :doc_type, :user_id, :template, :document, :case_ids => [])
    end
end
