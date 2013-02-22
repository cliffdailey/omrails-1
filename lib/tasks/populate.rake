namespace :db do
	desc "populate database with fake content"
	task populate: :environment do
		10.times do |n|
			name = Faker::Name.name
			email = "user-#{n+1}@example.com"
			password = "password"
			User.create!(name: name,
									 email: email,
									 password: password,
									 password_confirmation: password)
		end
		User.all.each do |user|
			10.times do |n|
				image = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample)
				description = %w(cool awesome bodacious incredible amazing).sample
				user.pins.create!(image: image,
												  description: description)
			end
		end
	end
end