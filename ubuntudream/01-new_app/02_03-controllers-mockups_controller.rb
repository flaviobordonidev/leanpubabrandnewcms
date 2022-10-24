class MockupsController < ApplicationController
  def page_a
    render layout: 'basic'
  end

  def edu_sign_in
    render layout: 'edu_demo'
  end

  def edu_index
    render layout: 'edu_demo'
  end

  def edu_student_bookmark
    render layout: 'edu_demo'
  end

  def edu_faq
    render layout: 'edu_demo'
  end

  def sign_in
    render layout: 'edu_demo'
  end

  def homepage
    render layout: 'edu_demo'
  end

  def lessons_show
    render layout: 'edu_demo'
  end

  def lessons_show_steps_show
    render layout: 'edu_demo'
  end

  def users_show
    render layout: 'edu_demo'
  end

  def users_edit
    render layout: 'edu_demo'
  end
end
