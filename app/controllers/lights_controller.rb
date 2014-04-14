class LightsController < ApplicationController

  def index
    @lights = Light.all
  end

  def new
    @light = Light.new
  end

  def create
    @light = Light.new(light_params)
    if @light.save
      redirect_to :lights
    else
      render :new
    end
  end

  def edit
    @light = Light.find(params[:id])
  end

  def update
    @light = Light.find(params[:id])
    if @light.update_attributes(light_params)
      redirect_to :lights
    else
      render :edit
    end
  end

  def destroy
    @light = Light.find(params[:id])
    @light.destroy
    redirect_to :lights
  end

  private

  def light_params
    params.require(:light).permit(:light_id, :name)
  end

end
