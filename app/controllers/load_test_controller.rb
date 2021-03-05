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

  def reset_table
    table = params[:table].classify.constantize
    table.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!(table.table_name)
    redirect_to root_path, alert: "Reset table #{table.table_name}"
  end

  def seed_groups
    num_games = params[:num_games].to_i
    num_groups = params[:num_groups].to_i
    ActiveRecord::Base.transaction do
      user = User.first_or_create!(username: 'God', email: 'god@example.com', password: 'test123')
      timestamps = { created_at: Time.now, updated_at: Time.now }
      games = num_games.times.map { |i| { name: "Cool Game #{i}", **timestamps } }
      games_with_ids = Game.insert_all!(games)
      games_with_ids.each do |game|
        groups = num_groups.times.map { |i| { game_id: game['id'], group_name: "Cool Group #{i}", max_member_count: 5, **timestamps }}
        groups_with_ids = Group.insert_all!(groups)
        group_memberships = groups_with_ids.map { |group| { group_id: group['id'], user_id: user['id'], **timestamps } }
        GroupMembership.insert_all!(group_memberships)
      end
    end
    redirect_to root_path, alert: "Seeded #{num_games} games and #{num_groups} groups per game"
  end

  def seed_users
    num_users = params[:num_users].to_i
    encrypted_password = User.new.send(:password_digest, 'test123')
    ActiveRecord::Base.transaction do
      timestamps = { created_at: Time.now, updated_at: Time.now }
      users = num_users.times.map do |i|
        {
          username: "user#{i}",
          email: "user#{i}@example.com",
          encrypted_password: encrypted_password,
          **timestamps
        }
      end
      User.insert_all!(users)
    end
    redirect_to root_path, alert: "Seeded #{num_users} users"
  end
end
