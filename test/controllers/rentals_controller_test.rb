require "test_helper"

describe RentalsController do
  let(:new_video) {
    videos(:video1)
  }

  let(:customer1) { customers(:customer1) }

  let(:rental_data) {
    {
      customer_id: customer1.id, 
      video_id: new_video.id
    }
  }


  describe "checkout" do
    before do
      rental_data = {
        customer_id: customer1.id, video_id: new_video.id
      }
    end

    it "creates a rental" do
      expect { 
        post check_out_path, params: rental_data 
      }.must_differ "Rental.count", 1

      check_response(expected_type: Hash)
    end

    it "gives a bad request response for invalid customer id" do
      # Arrange - using let from above
      rental_data[:customer_id] = nil

      expect {
        # Act
        post check_out_path, params: rental_data

      # Assert
      }.wont_change "Video.count"
    
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"].keys).must_include "customer_id"
    end

    it "gives a bad request response for invalid video id" do
      # Arrange - using let from above
      rental_data[:video_id] = nil

      expect {
        # Act
        post check_out_path, params: rental_data

      # Assert
      }.wont_change "Video.count"
    
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"].keys).must_include "video_id"
    end

    it "has a checkout date" do
      post check_out_path, params: rental_data
      
      expect(Rental.last.check_out_date).must_equal Date.today
    end

    it "increases customer's videos_checked_out_count by 1" do
      expect(customer1.videos_checked_out_count).must_equal 0
      
      post check_out_path, params: @rental_hash
      
      expect(customer1.videos_checked_out_count).must_equal 1
    end

    it "decreases the video's available inventory by one" do
      expect(new_video.available_inventory).must_equal 5
      
      expect{post check_out_path, params: rental_data}.must_differ "new_video.available_inventory", -1
      
      expect(new_video.available_inventory).must_equal 4
    end

    it "adds a due date 7 days after the checkout" do
      post check_out_path, params: rental_data
      
      expect(Rental.last.due_date).must_equal Date.today + 7
    end

  end

  describe "checkin" do ### underconstrucion
    it "checks in a valid rental" do
      # Arrange


      # Act
      expect {
        post check_in_path, params: check_in_data
      }.must_differ "Video.count", 1
  
      check_response(expected_type: Hash, expected_status: :created)
  
      # Assert

    end

    it "rejects an invalid rental" do
      # Arrange


      # Act


      # Assert

    end


  end

end
