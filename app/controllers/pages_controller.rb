class PagesController < ApplicationController

  def party
    @lights = Light.all
  end

end
