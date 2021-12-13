class MockupsController < ApplicationController
  def page_a
    render layout: 'dashboard'
  end

  def page_b
    render layout: 'mockup'
  end
  
  def login
    render layout: 'mockup'
  end
  
  def blog_clean_full_width
    render layout: 'yield'
  end

  def blog_post_layout_05
    render layout: 'yield'
  end

  def bactosense_home
    render layout: 'yield'
  end


  # Story 1: inseriamo nuovo contatto da Biglietto da Visita

  # Story 1 - Page 0
  def s1p0_work_in_progress
    render layout: 'mockup'
  end
  
  # Story 1 - Page 1
  def s1p1_home
    render layout: 'mockup'
  end

  # Story 1 - Page 2
  def s1p2_company_index
    render layout: 'mockup'
  end

  # Story 1 - Page 3
  def s1p3_company_new
    render layout: 'mockup'
  end

  # Story 1 - Page 4
  def s1p4_company_index
    render layout: 'mockup'
  end

  # Story 1 - Page 5
  def s1p5_company_person_index
    render layout: 'mockup'
  end


  # Story 2: inseriamo nuova persona non legata a nessuna azienda

  # Story 2 - Page 2
  def s2p2_people_index
    render layout: 'mockup'
  end

  # Story 2 - Page 3
  def s2p3_people_new
    render layout: 'mockup'
  end

  # Story 3: prova video per ubuntudream

  # Story 3 - Page 1
  def s3p1_videos_show
    render layout: 'mockup'
  end

  # Story 3 - Page 2
  def s3p2_videos_show
    render layout: 'mockup'
  end

  # youtube-video
  def youtube_video
    render layout: 'mockup'
  end

end
