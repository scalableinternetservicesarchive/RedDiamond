Rails.configuration.after_initialize do
  if !Rails.env.test? && ActiveRecord::Base.connection.table_exists?(:games) && Game.count.zero?
    Game.create!(name: 'League of Legends')
    Game.create!(name: 'Overwatch')
    Game.create!(name: 'Minecraft')
    Game.create!(name: 'Splatoon 2')
  end
end