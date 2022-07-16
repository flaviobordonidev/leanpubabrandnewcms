class MockupsController < ApplicationController
  def index
    render layout: "edu_base"
  end

  def course_list
    render layout: "edu_base"
  end
end