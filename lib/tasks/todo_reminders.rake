namespace :todos do
  desc "Send reminders for todos due tomorrow"
  task send_reminders: :environment do
    puts "Queueing reminder emails..."
    SendRemindersJob.perform_now
    puts "Done!"
  end
end
