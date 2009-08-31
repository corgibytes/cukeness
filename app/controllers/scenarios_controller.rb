class ScenariosController < ApplicationController
  def create
    if request.post?
      feature = Feature.find(:first, :conditions => "name = '#{params[:feature_name]}'")
      
      if !feature
        feature = Feature.new :name => params[:feature_name]
        feature.save
      end
      
      scenario = Scenario.new :name => params[:scenario_name], :body => params[:scenario_body]
      scenario.feature = feature
      scenario.save    
      
      redirect_to :controller => :home, :action => :index
    else
      render :nothing => true, :status => "404"
    end
  end
end
