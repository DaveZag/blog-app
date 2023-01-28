class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments
  after_initialize :update_posts_counter

  validates :name, presence: true
  validates :posts_counter, numericality: true, comparison: { greater_than_or_equal_to: 0 }

  def update_posts_counter
    self.posts_counter = 0 unless posts_counter
  end

  private :update_posts_counter

  # return 3 latests posts
  def latest_posts
    Post.where(author_id: id).order(created_at: :desc).limit(3)
  end
end
