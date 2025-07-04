class ConversationSkip < ApplicationRecord

  belongs_to :conversation
  belongs_to :agent, class_name: 'User'

  validates :conversation_id, presence: true
  validates :agent_id, presence: true

  # We define a default skip duration (e.g., 24 hours)
  scope :recent_by_agent, ->(agent_id, duration = 24.hours) {
    where(agent_id: agent_id)
      .where('created_at >= ?', Time.current - duration)
  }
end
