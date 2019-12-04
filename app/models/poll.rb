class Poll < ApplicationRecord
  has_many :poll_options, dependent: :destroy
  belongs_to :lecture
  validates :title, presence: true
  validates :is_multiselect, inclusion: { in: [true, false] }
  validates :is_active, inclusion: { in: [true, false] }

  def only_one_poll_active
    Poll.exists?(lecture_id: lecture.id, )
  end
end
