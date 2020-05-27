require "test_helper"

describe CustomersController do
  it "must get index" do
    get customers_path
    must_respond_with :success
  end

  it "responds with JSON and success" do
    get customers_path

    expect(response.header['Content-Type']).must_include 'json'
    must_respond_with :ok
  end



end
