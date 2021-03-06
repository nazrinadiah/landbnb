class User::ListingsController < ApplicationController

  before_action :find_and_check_user, except: [:show, :show_reservation]
  before_action :find_listing, except: [:index, :new]

  def show_reservation
    @reservation = Reservation.find(params[:reservation_id])
  end

  def index
    @listings = @user.listings
  end

  def show
  end

  def new
  end

  def create
    @listing = @user.listings.new(listing_params)

    if @listing.save
      redirect_to user_listing_path(current_user, @listing)
    else
      flash[:warning] = "Invalid input(s)"
      render :new
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to user_listing_path(current_user, @listing)
    else
      flash[:warning] = "Invalid input(s)"
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_path
  end

  private

  def find_and_check_user
    @user = User.find(params[:user_id])
    unless @user && @user == current_user
      redirect_to '/'
    end
  end

  def find_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:country, :state, :city, :home_type, :room_type, :address,
                                    :guest_number, :price_per_night, :title, :description, :tags_list,
                                    { images: [] })
  end
end
