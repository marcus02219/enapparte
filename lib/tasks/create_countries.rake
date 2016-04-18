require 'carmen'
namespace :db do
  desc "Create countries"
  task :create_countries => :environment do
    Language.delete_all
    ActiveRecord::Base.transaction do
      Carmen::Country.all.each do |country|
        Language.create(title: country.name)
      end
    end
  end
end