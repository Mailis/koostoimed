class AtcsController < ApplicationController
  # http_basic_authenticate_with :name => "dhh", :password => "secret"
  # GET /atcs
  # GET /atcs.json
  def index
    @atcs = Atc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @atcs }
    end
  end

  # GET /atcs/1
  # GET /atcs/1.json
  def show
    @atc = Atc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @atc }
    end
  end

  # GET /atcs/new
  # GET /atcs/new.json
  def new
    @atc = Atc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @atc }
    end
  end

  # GET /atcs/1/edit
  def edit
    @atc = Atc.find(params[:id])
  end

  # POST /atcs
  # POST /atcs.json
  def create
    @atc = Atc.new(params[:atc])

    respond_to do |format|
      if @atc.save
        format.html { redirect_to @atc, notice: 'Atc was successfully created.' }
        format.json { render json: @atc, status: :created, location: @atc }
      else
        format.html { render action: "new" }
        format.json { render json: @atc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /atcs/1
  # PUT /atcs/1.json
  def update
    @atc = Atc.find(params[:id])

    respond_to do |format|
      if @atc.update_attributes(params[:atc])
        format.html { redirect_to @atc, notice: 'Atc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @atc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /atcs/1
  # DELETE /atcs/1.json
  def destroy
    @atc = Atc.find(params[:id])
    @atc.destroy

    respond_to do |format|
      format.html { redirect_to atcs_url }
      format.json { head :no_content }
    end
  end
end
