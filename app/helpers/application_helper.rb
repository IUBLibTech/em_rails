module ApplicationHelper
  TEMPLE_URL = "https://tupress.temple.edu/"
  IU_URL = "https://iupress.org/"

  def iu_press_link
    IU_URL
  end

  def temple_press_link
    TEMPLE_URL
  end

end
