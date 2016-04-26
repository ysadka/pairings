class WinesController < ApplicationController

  def index
    @wines = Wine.all
  end

  def show
    @wine = Wine.find_by(id: params[:id])
  end

  def new
    @wine = Wine.new
  end

  def create
    @wine = Wine.create(wine_params)
    if @wine
      redirect_to wines_path
    else
      render :new
    end
  end

  def grape_variety
    grape = Grape.find_by(varietal: params[:type])
    @varieties = Wine.where(grape_id: grape.id)
  end

  def variety
    @varieties = Wine.where(category_type: params[:type])
  end

  private

  def wine_params
    params.require(:wine).permit(
      :vintage,
      :winery,
      :grape_type,
      :appellation,
      :variety,
      :alcohol_percentage,
      :serving_temperature,
      :sweetness,
      :acidity,
      :tanin,
      :fruit,
      :body,
      :photo
     )
  end
end
