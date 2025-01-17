export default {
  "/topics/messages-assigned/eviltrout.json": {
    users: [
      {
        id: -2,
        username: "discobot",
        name: "discobot",
        avatar_template: "/user_avatar/localhost/discobot/{size}/1_2.png"
      },
      {
        id: -1,
        username: "system",
        name: "system",
        avatar_template: "/user_avatar/localhost/system/{size}/2_2.png"
      }
    ],
    primary_groups: [],
    topic_list: {
      can_create_topic: true,
      draft: null,
      draft_key: "new_topic",
      draft_sequence: 0,
      per_page: 30,
      topics: [
        {
          id: 10,
          title: "Greetings!",
          fancy_title: "Greetings!",
          slug: "greetings",
          posts_count: 1,
          reply_count: 0,
          highest_post_number: 4,
          image_url:
            "//localhost:3000/plugins/discourse-narrative-bot/images/font-awesome-ellipsis.png",
          created_at: "2019-05-08T13:52:39.394Z",
          last_posted_at: "2019-05-08T13:52:39.841Z",
          bumped: true,
          bumped_at: "2019-05-08T13:52:39.841Z",
          unseen: false,
          last_read_post_number: 4,
          unread: 0,
          new_posts: 0,
          pinned: false,
          unpinned: null,
          visible: true,
          closed: false,
          archived: false,
          notification_level: 3,
          bookmarked: false,
          liked: false,
          views: 0,
          like_count: 0,
          has_summary: false,
          archetype: "private_message",
          last_poster_username: "discobot",
          category_id: null,
          pinned_globally: false,
          featured_link: null,
          posters: [
            {
              extras: "latest single",
              description: "Original Poster, Most Recent Poster",
              user_id: -2,
              primary_group_id: null
            }
          ],
          participants: [
            {
              extras: "latest",
              description: null,
              user_id: -2,
              primary_group_id: null
            }
          ],
          assigned_to_user: {
            id: 19,
            username: "eviltrout",
            name: null,
            avatar_template:
              "/letter_avatar_proxy/v4/letter/r/ed8c4c/{size}.png"
          }
        }
      ]
    }
  }
};
