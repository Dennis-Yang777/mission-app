class Mission < ApplicationRecord
	validates :title, presence: true
	validates :start_time, presence: true
	validates :end_time, presence: true
	belongs_to :user

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
