class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[ index]
  
  def home
  end 
  
  def index
    
  end

end
