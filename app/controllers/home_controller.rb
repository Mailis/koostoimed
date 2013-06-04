# encoding: utf-8
class HomeController < ApplicationController
 
  def index
   @pealkirjad = Omadused::TITLES
  end
  
  def soovita  
    inser = (params[:inserted])
    ident = (params[:ident])
    soo= (inser.concat("%"))
    @soovitus = Atc.where("code like ?", soo).first(20) if ident=="atcs"
    @soovitus = Atc.where("nimetus_est like ?", soo).first(20) if ident=="est"
    @soovitus = Atc.where("nimetus_eng like ?", soo).first(20) if ident=="eng"
    render :partial => 'soovita', :content_type => 'text/html'
  end  
 
end
