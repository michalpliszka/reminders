require "rake"

namespace :users do
  desc "Archives user with a given email"
  task :archive, [:email] => :environment do |_task, args|
    email = args[:email]
    if email.present?
      user = find_user_by_email(email)
      Users::Archive.new(user).call
      puts "SUCCESS: User #{user} (#{email}) archived."
    else
      fail "ERROR: please provide an email in order to archive user!"
    end
  end

  private

  def find_user_by_email(email)
    user = UsersRepository.new.find_by_email(email)
    if user.present?
      user
    else
      fail "ERROR: can't find user with email: '#{email}'!"
    end
  end
end
