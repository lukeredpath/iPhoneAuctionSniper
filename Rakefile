CONFIG = ENV['CONFIG'] || 'Debug'

namespace :test do
  desc "Run all acceptance tests"
  task :acceptance do
    if system("xcodebuild -target Testing -configuration #{CONFIG} -sdk iphonesimulator4.0 build")
      system("cucumber")
    end
  end
end
