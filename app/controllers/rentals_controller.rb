class RentalsController < ApplicationController

  def checkout
    video = Video.find_by(id: params[:videos_id])
    customer = Customer.find_by(id: params[:customer_id])

    if customer.nil? || video.nil?
      render json: {
        errors: ["Not Found"]},
        status: :not_found
      return
    end

    @rental = Rental.new(
      customer_id: customer.id,
      video_id: video.id )

    @rental.due_date = Date.today + 7 

    
    if @rental.save
      customer.take_movie_home
      video.send_movie_out

      rental_data = {
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        due_date: rental.due_date,
        available_inventory: video.available_inventory,
        videos_checked_out_count: customer.videos_checked_out_count
      }

      render json: rental_data.as_json, status: :ok
      return
    else
      render json: {
        errors: ["Not Found"]},
        status: :not_found
      return
    end
  end


  def checkin
    video = Video.find_by(id: params[:video_id])
    
    if video.nil?
      render json: {
        errors: ["Video Not Found"]},
        status: :not_found
      return
    end

    customer = Customer.find_by(id: params[:customer_id])
    
    if customer.nil?
      render json: {
        errors: ["Customer Not Found"]},
        status: :not_found
      return
    end

    rental = Rental.find_by(customer_id: params[:customer_id], video_id: params[:video_id])
    
    if rental.nil?
      render json: {
        errors: ["Rental Not Found"]},
        status: :not_found
      return
    end

    if !rental.checkedin?
      render json: {
        errors: ["Rental Already Checked-In"]},
        status: :bad_request
      return
    end

    rental.checkin(Date.today)
    rental.customer.update_checkout(-1)
    rental.video.update_inventory(+1)

    render json: {
      customer_id: rental.customer_id,
      video_id: rental.video_id,
      videos_checked_out_count: rental.customer.videos_checked_out_count,
      available_inventory: rental.video.available_inventory
    }

  end 

end
