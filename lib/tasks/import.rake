namespace :import do
  desc "Import Friendface likes data"
  task :likes, [:filename] => :environment do |t, args|
    Friendface::Importer.run(file: args[:filename])
  end
end