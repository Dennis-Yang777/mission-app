class Mission < ApplicationRecord
	validates :title, presence: true
	validates :start_time, presence: true
	validates :end_time, presence: true
	validates :priority, presence: true
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
end
