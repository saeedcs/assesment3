module Conversations
  class NextOpenConversationService
    attr_reader :account, :agent

    def initialize(account:, agent:)
      @account = account
      @agent = agent
    end

    def perform
      skip_duration = 24.hours

      skipped_conversation_ids = ConversationSkip.recent_by_agent(agent.id, skip_duration)
                                                 .pluck(:conversation_id)

      next_conversation = account.conversations
                                 .open
                                 .where.not(id: skipped_conversation_ids)
                                 .where(assignee_id: [nil, agent.id])
                                 .order(created_at: :asc)
                                 .first

      next_conversation
    end
  end
end
