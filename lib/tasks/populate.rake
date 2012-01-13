namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    require "factory_girl"
    Rake::Task['db:reset'].invoke

    FactoryGirl.create_list(:application_user, 5)
    8.times {
      FactoryGirl.create(:application_story, :user_id => "#{User.all.sample.id}")
    }
    50.times {
      FactoryGirl.create(:application_comment, :story_id => "#{Story.all.sample.id}")
    }
    #FactoryGirl.create_list(:story, 10, :user_id => "#{User.all.sample.id}")
    #FactoryGirl.create_list(:comment, 70, :story_id => "#{Story.all.sample.id}")
  end
end