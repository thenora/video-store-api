require "test_helper"

describe VideosController do

  REQUIRED_VIDEO_FIELDS = [
    "id", "title", "overview",
    "release_date", "total_inventory",
    "available_inventory"].sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end


  describe "index" do
    it "must get index" do
      get videos_path
      check_response(expected_type: Array)
    end

    it "responds with an array of video hashes" do
      # Act
      get videos_path

      # Assert
      body = check_response(expected_type: Array)
      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal REQUIRED_VIDEO_FIELDS
      end
    end

    it "will respond with an empty array when there are no videos" do
      # Arrange
      Video.destroy_all

      # Act
      get videos_path

      # Assert
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end

  describe "show" do
    let(:new_video) {
        Video.create(
          title: "Star Wars",
          overview: "Family Space Odissey",
          release_date: Date.today,
          total_inventory: 10,
          available_inventory: 5
        )
    }

    it "must get show for a valid video" do
      get video_path(new_video)
      video = check_response(expected_type: Hash)
      expect(video.keys.sort).must_equal REQUIRED_VIDEO_FIELDS
    end

    it "must return 404 for an invalid video" do
      get video_path(-1)
      video = check_response(expected_type: Hash, expected_status: :not_found)
    end
  end

  describe "create" do
    let(:video_data) {
      {
        video: {
          title: "Star Wars",
          overview: "Family Space Odissey",
          release_date: Date.today,
          total_inventory: 10,
          available_inventory: 5
        }
      }
    }
    it "can create a new video" do
      expect {
        post videos_path, params: video_data
      }.must_differ "Video.count", 1

      check_response(expected_type: Hash, expected_status: :created)
    end

    it "will respond with bad_request for invalid data" do
      # Arrange - using let from above
      video_data[:video][:title] = nil

      expect {
        # Act
        post videos_path, params: video_data

      # Assert
      }.wont_change "Video.count"
    
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"].keys).must_include "title"
    end
  end
  
end
