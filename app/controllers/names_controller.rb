class NamesController < ApplicationController
  def index
    @names = Name.all
  end

  def new
    @name = Name.new
  end

  def create
    @name = Name.new(name_params)
    @name.full_name = @name.first_name + " " + @name.last_name
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
      params.require(:name).permit(:first_name, :last_name, :full_name)
    end
end
