class LinksController < ApplicationController
 before_action :authenticate_user!

 def index
  @links = current_user.links
 end
 def new
  @link = Link.new
 end
 def create
  @link = current_user.links.new(params[:link])
  @link.strip_http!
  if @link.save
    flash[:success] = "LINK SAVED"
    redirect_to links_path

  else
    render 'new'

  end
 end
   def show

     @link = Link.find_by(:id => params[:id], :user_id => current_user.id)

     if @link.nil?
      flash[:warning] = "Link not found."
      redirect_to links_path
     end
   end
   def edit
    @link = Link.find_by(:id => params[:id]), :user_id => current_user.id)
    if @link.nil?
      flash[:warning] = "Link not found."
      redirect_to links_path
     end
     
   end
   def update
    @link = Link.find_by(:id => params[:id]), :user_id => current_user.id)
      if @link.update(params[:link])
      @link.strip_http!
     flash[:success] = "Link Updated"
     redirect_to link_path(@link.id)
      else
        render 'edit'
      end
   end
   def destroy
     @link = Link.find_by(:id => params[:id]), :user_id => current_user.id)
     @link.destroy
     flash[:success] = 'Link deleted.'
     redirect_to links_path

   end
end
