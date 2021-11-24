module ApplicationHelper

  def page_title(page_title = '')
    base_title = 'CAMPHOOD'
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  # def campsite_count
  #   Campsite.all.ids.count
  # end
  # <h6 class="mt-4 mb-3"><%= "無料キャンプ場は全国に#{campsite_count}件あります" %></h6>

end
