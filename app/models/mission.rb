class Mission < ApplicationRecord
	validates :title, :priority, :start_time, :end_time, presence: true
  validate :check_date, on: [:create, :update]
	belongs_to :user

  scope :desc, -> { order(start_time: :desc) }
  scope :user_missions, -> (user) { where(user_id: user) }
  enum priority_state: {low: 0, medium: 1, high: 2}

	include AASM
  aasm column: 'state' do
    state :pending, initial: true
    state :running, :finished

    event :run do
      transitions from: :pending, to: :running
    end

    event :finish do
      transitions from: :running, to: :finished
    end

    event :sleep do
      transitions from: :running, to: :pending
    end
  end

  private
    def check_date
      if self.start_time >= self.end_time
        errors.add(:time_error, "開始時間不可大於結束時間")
      end
    end
end
