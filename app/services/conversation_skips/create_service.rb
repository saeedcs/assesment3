module ConversationSkips
  class CreateService
    attr_reader :conversation, :agent, :reason

    def initialize(conversation:, agent:, reason: nil)
      @conversation = conversation
      @agent = agent
      @reason = reason
    end

    def perform
      raise StandardError, 'Conversation or Agent cannot be nil' unless conversation && agent

      conversation_skip = ConversationSkip.create!(
        conversation: conversation,
        agent: agent,
        reason: reason
      )
      conversation_skip
    end
  end
end
