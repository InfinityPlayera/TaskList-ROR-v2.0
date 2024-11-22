class Task < ApplicationRecord
    before_save :ensure_completed_value

    private

    def ensure_completed_value
        self.completed = false if completed.nil?
        max_position = Task.maximum(:position) || 0
        self.position = max_position + 1
    end
end
