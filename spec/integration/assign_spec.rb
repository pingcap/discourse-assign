# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/assign_allowed_group'

describe 'integration tests' do
  before do
    SiteSetting.assign_enabled = true
  end

  it 'preloads data in topic list' do
    admin = Fabricate(:admin)
    post = create_post
    list = TopicList.new("latest", admin, [post.topic])
    TopicList.preload([post.topic], list)
    # should not explode for now
  end

  describe 'data consistency' do
    it 'can deal with problem custom fields' do
      post = Fabricate(:post)
      post.topic.custom_fields[TopicAssigner::ASSIGNED_TO_ID] = [nil, nil]
      post.topic.save_custom_fields

      TopicAssigner.new(Topic.find(post.topic_id), Discourse.system_user).unassign

      post.topic.reload
      expect(post.topic.custom_fields).to eq({})
    end
  end

  describe 'for a private message' do
    let(:post) { Fabricate(:private_message_post) }
    let(:pm) { post.topic }
    let(:user) { pm.allowed_users.first }
    let(:user2) { pm.allowed_users.last }
    let(:channel) { "/private-messages/assigned" }

    include_context 'A group that is allowed to assign'

    before do
      add_to_assign_allowed_group(user)
      add_to_assign_allowed_group(user2)
    end

    def assert_publish_topic_state(topic, user)
      messages = MessageBus.track_publish do
        yield
      end

      message = messages.find { |m| m.channel == channel }

      expect(message.data[:topic_id]).to eq(topic.id)
      expect(message.user_ids).to eq([user.id])
    end

    it 'publishes the right message on archive and move to inbox' do
      assigner = TopicAssigner.new(pm, user)
      assigner.assign(user)

      assert_publish_topic_state(pm, user) do
        UserArchivedMessage.archive!(user.id, pm.reload)
      end

      assert_publish_topic_state(pm, user) do
        UserArchivedMessage.move_to_inbox!(user.id, pm.reload)
      end
    end
  end

  describe "on assign_topic event" do
    let(:post) { Fabricate(:post) }
    let(:topic) { post.topic }
    let(:admin) { Fabricate(:admin) }
    let(:user1) { Fabricate(:user) }
    let(:user2) { Fabricate(:user) }

    include_context 'A group that is allowed to assign'

    before do
      add_to_assign_allowed_group(user1)
      add_to_assign_allowed_group(user2)
    end

    it "assigns topic" do
      DiscourseEvent.trigger(:assign_topic, topic, user1, admin)
      expect(topic.reload.custom_fields[TopicAssigner::ASSIGNED_TO_ID].to_i).to eq(user1.id)

      DiscourseEvent.trigger(:assign_topic, topic, user2, admin)
      expect(topic.reload.custom_fields[TopicAssigner::ASSIGNED_TO_ID].to_i).to eq(user1.id)

      DiscourseEvent.trigger(:assign_topic, topic, user2, admin, true)
      expect(topic.reload.custom_fields[TopicAssigner::ASSIGNED_TO_ID].to_i).to eq(user2.id)
    end
  end
end
