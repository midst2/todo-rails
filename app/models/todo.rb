class Todo < ApplicationRecord
  enum :priority, { Low: 0, Medium: 1, High: 2 }
end
