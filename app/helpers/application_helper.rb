module ApplicationHelper
  def fix_url(url)
    url.starts_with?("http") ? url : "http://" + url
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %I:%M%p %Z") # 03/04/2015 3:50pm EST
  end
end
