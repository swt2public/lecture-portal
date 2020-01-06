require "rails_helper"

describe "The show lecture page", type: :feature do
  # Include Devise helpers that allow usage of `sign_in`
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @lecturer = FactoryBot.create(:user, :lecturer)
    @lecture = FactoryBot.create(:lecture, lecturer: @lecturer)
    sign_in @lecturer
  end

  it "should have no end button if the lecture is not running" do
    visit(course_lecture_path(course_id: @lecture.course.id, id:@lecture.id))
    expect(page).not_to have_selector("input[type=submit][value='End']")
  end


  it "should have an end button if the lecture is running" do
    @lecture.update(status: "running")
    visit(course_lecture_path(course_id: @lecture.course.id, id:@lecture.id))
    expect(page).to have_selector("input[type=submit][value='End']")
  end

  it "should end the lecture if the end button is clicked" do
    @lecture.update(status: "running")
    visit(course_lecture_path(course_id: @lecture.course.id, id:@lecture.id))
    click_on("End")
    @lecture.reload
    expect(@lecture.status).to eq("ended")
  end

  it "should not be accesible by another lecturer" do
    @lecture2 = FactoryBot.create(:lecture)
    visit(course_lecture_path(course_id: @lecture2.course.id, id:@lecture2.id))
    expect(page).to_not have_current_path(course_lecture_path(course_id: @lecture2.course.id,id:@lecture2))
  end
end
