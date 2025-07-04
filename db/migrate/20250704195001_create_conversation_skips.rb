class CreateConversationSkips < ActiveRecord::Migration[7.1]
  def change
    create_table :conversation_skips do |t|
      t.references :conversation, null: false, foreign_key: true
      t.references :agent, null: false, foreign_key: { to_table: :users }
      t.text :reason, null: true

      t.timestamps
    end

    add_index :conversation_skips, [:conversation_id, :agent_id], unique: false
    add_index :conversation_skips, [:agent_id, :created_at]
  end
end
