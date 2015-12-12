class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]

  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin
      flash[:notice] = "Successfully created new Pin"
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin
      flash[:notice] = "Pin was successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to root_path

  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description)
  end

  def set_pin
    @pin = current_user.pins.find(params[:id])
  end
end
