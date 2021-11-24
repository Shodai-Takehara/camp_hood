require 'csv'

csv_data = CSV.read('db/seeds/campsites_with_header.csv', headers: true)
csv_data.each do |data|
  Campsite.create!(data.to_hash)
end
