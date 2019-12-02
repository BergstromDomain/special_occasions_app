class NamesController < ApplicationController
  def index
  end

  def new
    @name = Name.new
  end

  def create
    @name = Name.new(name_params)
    if @name.save
      flash[:sucess] = "The name has been created"
      redirect_to root_path
    else
      flash.now[:danger] = "The name has not been created"
      render :new
    end
  end

  private
    def name_params
      params.require(:name).permit(:first_name, :last_name)
    end
end
