class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  after_initialize :update_self_counters
  after_save :update_posts_counter

  # Update the posts counter
  def update_posts_counter
    User.find(author_id).increment!(:posts_counter)
  end

  # Return the five latest comments
  def latest_comments
    Comment.find(post_id).order(created_at: :desc).limit(5)
  end

  def update_self_counters
    self.likes_counter = 0 unless likes_counter
    self.comments_counter = 0 unless comments_counter
  end

  private :update_self_counters
end
