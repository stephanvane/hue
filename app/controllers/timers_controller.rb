class TimersController < ApplicationController

  def index
    @timers = Timer.all
  end

  def new
    @timer = Timer.new
  end

  def create
    @timer = Timer.new(timer_params)
    if @timer.save
      redirect_to :timers
    else
      render 'new'
    end
  end

  def edit
    @timer = Timer.find(params[:id])
  end

  def update
    @timer = Timer.find(params[:id])
    if @timer.update_attributes(timer_params)
      redirect_to :timers
    else
      render 'edit'
    end
  end

  def destroy
    @timer = Timer.find(params[:id])
    @timer.destroy
    redirect_to :timers
  end

  def timer_params
    params.require(:timer).permit(:hue, :sat, :bri, :at, :name, light_ids: [])
  end

end
