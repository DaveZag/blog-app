class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  after_initialize :update_self_counter
  after_save :update_posts_counter

  validates :title, length: { maximum: 250 }, presence: true
  validates :comments_counter, numericality: true, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: true, comparison: { greater_than_or_equal_to: 0 }

  # Update the posts counter
  def update_posts_counter
    User.find(author_id).increment!(:posts_counter)
  end

  # Return the five latest comments
  def latest_comments
    Comment.includes([:author]).where(post_id: id).order(created_at: :desc).limit(5)
  end

  def update_self_counter
    self.likes_counter = 0 unless likes_counter
    self.comments_counter = 0 unless comments_counter
  end

  private :update_self_counter
end
