class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform
    now = Time.current

    # 1. Todos with a custom remind_at set by the user — send when that time has passed
    custom = Todo.where(reminder_sent: false, status: false)
                 .where.not(remind_at: nil)
                 .where("remind_at <= ?", now)

    # 2. Todos with no remind_at set — fall back to 1 day before due_date
    default_remind = Todo.where(reminder_sent: false, status: false, remind_at: nil)
                         .where(due_date: Date.tomorrow)

    (custom + default_remind).each do |todo|
      begin
        TodoMailer.reminder_email(todo).deliver_now
        todo.update!(reminder_sent: true)
      rescue => e
        Rails.logger.error "Failed to send reminder for todo ##{todo.id}: #{e.message}"
      end
    end
  end
end
