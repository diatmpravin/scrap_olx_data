require "nokogiri"
require "open-uri"

class WagonrsController < ApplicationController
  before_action :set_wagonr, only: [:show, :edit, :update, :destroy]

  # GET /wagonrs
  # GET /wagonrs.json
  def index
    # @wagonrs = Wagonr.all
    @wagonrs = Wagonr.where(:model => '2002')
  end

  # GET /wagonrs/1
  # GET /wagonrs/1.json
  def show
  end

  # GET /wagonrs/new
  def new
    @wagonr = Wagonr.new
  end

  # GET /wagonrs/1/edit
  def edit
  end

  # POST /wagonrs
  # POST /wagonrs.json
  def create
    @wagonr = Wagonr.new(wagonr_params)

    for i in 1..12
      url = @wagonr[:base_link]+ "/-p-" + i.to_s
      doc = Nokogiri::HTML(open(url))
      for xxx in 1..30
        _href = doc.xpath("html/body/div/div[2]/div[3]/div[3]/div[6]/div/div["+xxx.to_s+"]/div[2]/h3/a").map { |link| link['href'] } 
        unless _href.nil?
          doc1 = Nokogiri::HTML(open(_href.first))
          
          @name = doc1.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div/div").text.gsub('à¤°', '') unless doc1.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div/div").nil?
          @price = doc1.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div[2]/div[2]/div/strong").text.gsub('à¤°', ' ') unless doc1.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div[2]/div[2]/div/strong").nil?
          @mileage = doc1.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div[2]/div[2]/div[2]/strong").text.gsub('à¤°', ' ') unless doc1.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div[2]/div[2]/div[2]/strong").nil?
          @model = doc1.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div[2]/div[2]/div[3]/strong").text.gsub('à¤°', ' ') unless doc1.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div[2]/div[2]/div[3]/strong").nil?
          # @posted_date = doc1.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div[2]/div[2]/div[4]/strong").text.gsub('à¤°', ' ') unless doc1.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div[2]/div[2]/div[4]/strong").nil?

          unless @name.nil? || @price.nil? || @mileage.nil? || @model.nil?# || @posted_date.nil?
            @final = Wagonr.create(:name => @name.strip, :price => @price.strip, :model => @model.strip, :Mileage => @mileage.strip, :base_link => _href)
            # @final = Wagonr.create(:name => @name.strip, :price => @price.strip, :model => @model.strip, :Mileage => @mileage.strip, :posted_date => @posted_date)
          end
        end  
      end
    end
    
    # doc = Nokogiri::HTML(open(url)) 
    # @name = doc.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div/div").text.gsub('à¤°', '')
    # @price = doc.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div[2]/div[2]/div/strong").text.gsub('à¤°', ' ')
    # @mileage = doc.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div[2]/div[2]/div[2]/strong").text.gsub('à¤°', ' ')
    # @model = doc.at_xpath("/html/body/div/div[2]/div[5]/div/div[3]/div[2]/div[2]/div[3]/strong").text.gsub('à¤°', ' ')
    # puts @name.strip
    # puts @price.strip
    # puts @mileage.strip
    # puts @model.strip
    
    # @final = Wagonr.new(:name => @name.strip, :price => @price.strip, :model => @model.strip, :Mileage => @mileage.strip)

    respond_to do |format|
      if @final.save
        format.html { redirect_to @wagonr, notice: 'Wagonr was successfully created.' }
        format.json { render action: 'show', status: :created, location: @wagonr }
      else
        format.html { render action: 'new' }
        format.json { render json: @wagonr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wagonrs/1
  # PATCH/PUT /wagonrs/1.json
  def update
    respond_to do |format|
      if @wagonr.update(wagonr_params)
        format.html { redirect_to @wagonr, notice: 'Wagonr was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @wagonr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wagonrs/1
  # DELETE /wagonrs/1.json
  def destroy
    @wagonr.destroy
    respond_to do |format|
      format.html { redirect_to wagonrs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wagonr
      @wagonr = Wagonr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wagonr_params
      params.require(:wagonr).permit(:olx_id, :posted_date, :model, :Mileage, :price, :name, :base_link)
    end
end
