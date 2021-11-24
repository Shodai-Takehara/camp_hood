namespace :seed do
  Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')).each do |file|
    desc "db/seeds/#{File.basename(file)}を実行"
    task "db:seed:#{File.basename(file).gsub(/\.rb/, '')}": :environment do
      load(file)
    end
  end
end
