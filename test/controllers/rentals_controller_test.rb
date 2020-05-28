require "test_helper"

describe RentalsController do
  let(:new_video) {
    Video.create(
      title: "Star Wars",
      overview: "Family Space Odyssey",
      release_date: Date.today,
      total_inventory: 10,
      available_inventory: 5
    )
  }

  describe "checkin" do ### underconstrucion
    it "checks in a valid rental" do
      # Arrange


      # Act
      expect {
        post checkin_path, params: checkin_data
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
