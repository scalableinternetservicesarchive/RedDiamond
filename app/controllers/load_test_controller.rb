class LoadTestController < ApplicationController
  def sign_in_as_new_user
    new_user = SecureRandom.alphanumeric(10)
    sign_in(:user, User.create(username: new_user, email: "#{new_user}@example.com", password: new_user))
    redirect_to root_path
  end

  def seed_games
    if Game.count.zero?
      Game.create!(name: 'League of Legends')
      Game.create!(name: 'Overwatch')
      Game.create!(name: 'Minecraft')
      Game.create!(name: 'Splatoon 2')

      redirect_to root_path, notice: 'Seeded games'
    else
      redirect_to root_path, alert: 'Games already exist'
    end
  end
end
