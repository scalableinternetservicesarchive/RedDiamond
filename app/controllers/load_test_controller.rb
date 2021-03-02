class LoadTestController < ApplicationController
  def sign_in_as_new_user
    new_user = SecureRandom.alphanumeric(10)
    sign_in(:user, User.create(username: new_user, email: "#{new_user}@example.com", password: new_user))
    redirect_to root_path
  end
end
