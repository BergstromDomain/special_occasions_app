class NamesController < ApplicationController
  def index
    @names = Name.all
  end

  def new
    @name = Name.new
  end

  def create
    @name = Name.new(name_params)
    @name.full_name = "#{@name.first_name} #{@name.last_name}"
    if @name.save
      flash[:sucess] = "The name #{@name.full_name} has been created"
      redirect_to root_path
    else
      flash.now[:danger] = "The name #{@name.full_name} has not been created"
      render :new
    end
  end

  def show
    @name = Name.find(params[:id])
  end

  def edit
    @name = Name.find(params[:id])
  end

  def update
    @name = Name.find(params[:id])
    @name.full_name = "#{@name.first_name} #{@name.last_name}"
    if @name.update(name_params)
      flash[:sucess] = "The name #{@name.full_name} has been updated"
      redirect_to name_path(@name)
    else
      flash.now[:danger] = "The name #{@name.full_name} has not been updated"
      render :edit
    end
  end

  protected

    def resource_not_found
      message = "The name you are looking for could not be found"
      flash[:alert] = message
      redirect_to root_path
    end

  private

    def name_params
      params.require(:name).permit(:first_name, :last_name)
    end
end
