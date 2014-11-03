class PagesController < ApplicationController

  def party
    @lights = Light.all
    gon.jbuilder(template: 'app/views/lights/index.html')
  end

end
