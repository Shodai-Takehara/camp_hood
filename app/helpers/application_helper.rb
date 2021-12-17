module ApplicationHelper
  require "uri"

  def page_title(page_title = '', admin = false)
    base_title = if admin
      '【管理画面】'
    else
      'CAMPHOOD'
    end
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  # URLテキストにリンクを付与する
  def text_url_to_link(text)
    URI.extract(text, ['http','https'] ).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"

      text.gsub!(url, sub_text)
    end
    text
  end

  #パンクズリストの1ページ目のviewの分岐
  def breadcrumb_pagination
    if params[:page].nil? || params[:page] == 1
      breadcrumb :campsites
    else
      breadcrumb :campsites_pagination, params[:page]
    end
  end

  # def campsite_count
  #   Campsite.all.ids.count
  # end
  # h6 class="mt-4 mb-3"><%= "無料キャンプ場は全国に#{campsite_count}件あります" %>/h6>

end
