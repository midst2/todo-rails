# Preview all emails at http://localhost:3000/rails/mailers/todo_mailer
class TodoMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/todo_mailer/reminder_email
  def reminder_email
    TodoMailer.reminder_email
  end
end
