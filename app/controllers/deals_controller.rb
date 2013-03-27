class DealsController < ApplicationController
  before_filter :find_deal, :only=>[:show, :edit, :update, :destroy]
  
  respond_to :html, :js
  
  def index
    @deals = Deal.all
    respond_with(@deals)
  end

  def show
    respond_with(@deal)
  end

  def new
    @deal = Deal.new
    respond_with(@deal)
  end

  def edit
  end

  def create
    @deal = Deal.new(params[:deal])

    respond_to do |format|
      if @deal.save
        format.html { redirect_to @deal, notice: 'Deal was successfully created.' }
        format.json { render json: @deal, status: :created, location: @deal }
      else
        format.html { render action: "new" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @deal.update_attributes(params[:deal])
        format.html { redirect_to @deal, notice: 'Deal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to deals_url }
      format.json { head :no_content }
    end
  end
  
  def upload
    attachment = Image.new
    attachment.save
    attachment.attachment = params["files"][0]
    attachment.save
    viewHelper = Object.new.extend(ActionView::Helpers::NumberHelper)
    render :json => ['name' => '<a href="' + attachment.attachment.to_s + '">' + params["files"][0].original_filename + '</a>', 'size' => viewHelper.number_to_human_size(File.size(params["files"][0].tempfile)), 'id' => attachment.id, 'thumb' => attachment.thumb_url, 'big_thumb' => attachment.big_thumb_url]
  end
  
  def remove_upload
    if params[:id] && Image.find(params[:id])
      Image.find(params[:id]).destroy
    end
    @remove_id = params[:id]
  end
  
  protected
  def find_deal
    @deal = Deal.find(params[:id])
  end
  
end
