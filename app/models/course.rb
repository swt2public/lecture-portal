class Course < ApplicationRecord
  belongs_to :creator, class_name: :User
  has_and_belongs_to_many :participating_students, class_name: :User
  has_many :lectures, dependent: :destroy
  validates :name, presence: true, length: { in: 2..40 }
  enum status: { open: "open", closed: "closed" }
  has_many :uploaded_files, as: :allowsUpload

  def join_course(student)
    unless self.participating_students.include?(student)
      self.participating_students << student
    end
  end

  def leave_course(student)
    if self.participating_students.include?(student)
      self.participating_students.delete(User.find(student.id))
    end
  end

  def update_students_calendars
    self.participating_students.each do |student|
      student.update_calendar
    end
  end
end
