class NamesController < ApplicationController
  before_action :set_name, only: [:show, :edit, :update, :destroy]

  def index
    @names = Name.all
  end

  def new
    @name = Name.new
    @submit_button_name = "Create Name"
  end

  def create
    @name = Name.new(name_params)
    @name.full_name = "#{@name.first_name} #{@name.last_name}"
    if @name.save
      flash[:notice] = "The name #{@name.full_name} has been created"
      redirect_to root_path
    else
      flash.now[:danger] = "The name #{@name.full_name} has not been created"
      render :new
    end
  end

  def show
  end

  def edit
    @submit_button_name = "Update Name"
  end

  def update
    @name.full_name = "#{@name.first_name} #{@name.last_name}"
    if @name.update(name_params)
      flash[:notice] = "The name #{@name.full_name} has been updated"
      redirect_to name_path(@name)
    else
      flash.now[:danger] = "The name #{@name.full_name} has not been updated"
      render :edit
    end
  end

  def destroy
    if @name.destroy
      flash[:notice] = "The name #{@name.first_name} #{@name.last_name} has been deleted"
      redirect_to names_path
    end
  end

  protected

    def resource_not_found
      message = "The name you are looking for could not be found"
      flash[:alert] = message
      redirect_to root_path
    end

  private

    def set_name
      @name = Name.find(params[:id])
    end

    def name_params
      params.require(:name).permit(:first_name, :last_name)
    end
end
