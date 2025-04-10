# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "🌱 Resetting database..."

Intake.destroy_all
Supplement.destroy_all
User.destroy_all

puts "✅ All data cleared. Seeding fresh..."

puts 'Creating user...'
user = User.new(email_address: 'test@a.com', password: '890')
if user.save
  puts 'Successfully created 1 user.'
else
  puts 'Error creating user'
end

# First, create some supplements
supplements = [
  "Vitamin D3",
  "Magnesium",
  "Omega-3 Fish Oil",
  "Creatine Monohydrate",
  "Zinc"
].map do |name|
  Supplement.find_or_create_by!(name: name)
end

# Make sure there's at least one user to assign intakes to
user = User.first
unless user
  puts "No users found. Please create a user first (e.g., via registration or manually in seeds)."
  exit
end

# Create intakes for the user

Supplement.all.each do |supplement|
  Intake.create!(user: user, supplement: supplement)
end

puts "✅ Seeded #{supplements.count} supplements and 5 intakes for #{user.email_address}"
