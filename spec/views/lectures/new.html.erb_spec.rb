require "rails_helper"

RSpec.describe "lectures/new", type: :view do
  before(:each) do
    @course = FactoryBot.create(:course)
    @lecture = FactoryBot.create(:lecture, course: @course)
  end

  it "renders new lecture form" do
    render

    assert_select "form[action=?][method=?]",  course_lecture_path(course_id: @course.id, id: @lecture.id), "post" do
      assert_select "input[name=?]", "lecture[name]"

      assert_select "input[name=?]", "lecture[enrollment_key]"

      # components of time_select and date_select
      assert_select "select[name=?]", "lecture[date(1i)]"

      assert_select "select[name=?]", "lecture[date(2i)]"

      assert_select "select[name=?]", "lecture[date(3i)]"

      # there are 3 hidden inputs for start and end time, so the selects start with 4i
      assert_select "select[name=?]", "lecture[start_time(4i)]"

      assert_select "select[name=?]", "lecture[start_time(5i)]"

      assert_select "select[name=?]", "lecture[end_time(4i)]"

      assert_select "select[name=?]", "lecture[end_time(5i)]"

      assert_select "input[name=?]", "lecture[questions_enabled]"

      assert_select "input[name=?]", "lecture[polls_enabled]"

      assert_select "input[name=?]", "lecture[feedback_enabled]"
    end
  end
end
