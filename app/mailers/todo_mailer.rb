class TodoMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.todo_mailer.reminder_email.subject
  #
  def reminder_email(todo)
    @todo = todo
    @user = todo.user

    if @user&.email
      mail(to: @user.email, subject: "Reminder: Your Todo '#{@todo.content}' is due tomorrow")
    end
  end
end
