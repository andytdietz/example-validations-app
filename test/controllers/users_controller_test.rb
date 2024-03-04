require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/users.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal User.count, data.length
  end

  test "create" do
    assert_difference "User.count", 1 do
      post "/users.json", params: { first_name: "lake", last_name: "mountain", email: "blank@gmail.com", phone_number: "1234567" }
      assert_response 200
    end
  end

  test "show" do
    get "/users/#{User.first.id}.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal ["id", "first_name", "last_name", "email", "phone_number"], data.keys
  end

  test "update" do
    user = User.first
    patch "/users/#{user.id}.json", params: { first_name: "Updated first_name" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated first_name", data["first_name"]
  end

  test "destroy" do
    assert_difference "User.count", -1 do
      delete "/users/#{User.first.id}.json"
      assert_response 200
    end
  end
end
