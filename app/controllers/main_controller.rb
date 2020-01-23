class MainController < ApplicationController
  def index
  end

  def search
    render json: {
      characters: Character.mapped_search(q: params["q"])
    }.to_json
  end
end
