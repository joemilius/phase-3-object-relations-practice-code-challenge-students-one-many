class Cohort < ActiveRecord::Base
  has_many :students, dependent: :destroy

  def add_student(name, age)
    Student.create(name: name, age: age, email: null, cohort_id: self.id)
  end

  def average_age
    students.sum(:age).to_f / students.length
  end

  def total_students
    students.length
  end

  def self.biggest
    includes(:students).all.max_by {|cohort| cohort.students.length}
  end

  def self.sort_by_mod
    all.sort_by {|cohort| cohort.current_mod}
  end
end