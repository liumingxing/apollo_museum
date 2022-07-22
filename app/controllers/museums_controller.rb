class MuseumsController < ApplicationController
  def index
    @museums = Museum.paginate(page: params[:page], per_page: 20)
    if params[:filter].present?
      like = "%#{params[:filter]}%"
      @museums = @museums.where(["city like ? or name like ? or description like ?", like, like, like])
    end
  end
end
