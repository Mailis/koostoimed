class OmadusedsController < ApplicationController
  # http_basic_authenticate_with :name => "dhh", :password => "secret"
  # GET /omaduseds
  # GET /omaduseds.json
  
  def index
    @omaduseds = Omadused.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @omaduseds }
    end
  end

  # GET /omaduseds/1
  # GET /omaduseds/1.json
  def kuva    
     toimeaine_query = Omadused.fetch((params[:atc]).gsub(/\s/, ""))
     
     
     @error_info = toimeaine_query[:errror]
     @tabeliRidadeArv = toimeaine_query[:tabeliRidadeArv]
     @omadused = toimeaine_query[:toimea]
     respond_to do |format|
       format.html
     end #render :partial => 'kuva', :content_type => 'text/html'
  end
  

  # GET /omaduseds/new
  # GET /omaduseds/new.json
  def new
    @omadused = Omadused.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @omadused }
    end
  end

  # GET /omaduseds/1/edit
  def edit
    @omadused = Omadused.find(params[:id])
  end

  # POST /omaduseds
  # POST /omaduseds.json
  def create
    @omadused = Omadused.new(params[:omadused])
    omaduseds_dublecheck = Omadused.all
    isdouble = omaduseds_dublecheck.include? @omadused
    
    if !isdouble
     respond_to do |format|
        if @omadused.save
          format.html { redirect_to @omadused, notice: 'Omadused was successfully created.' }
          format.json { render json: @omadused, status: :created, location: @omadused }
        else
          format.html { render action: "new" }
          format.json { render json: @omadused.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /omaduseds/1
  # PUT /omaduseds/1.json
  def update
    @omadused = Omadused.find(params[:id])

    respond_to do |format|
      if @omadused.update_attributes(params[:omadused])
        format.html { redirect_to @omadused, notice: 'Omadused was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @omadused.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /omaduseds/1
  # DELETE /omaduseds/1.json
  def destroy
    @omadused = Omadused.find(params[:id])
    @omadused.destroy

    respond_to do |format|
      format.html { redirect_to omaduseds_url }
      format.json { head :no_content }
    end
  end
  
end
