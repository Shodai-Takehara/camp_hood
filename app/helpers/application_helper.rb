module ApplicationHelper
  require "uri"

  def page_title(page_title = '', admin = false)
    base_title =
    if admin
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

  # パンクズリストの1ページ目のviewの分岐
  def breadcrumb_pagination
    if params[:page].nil? || params[:page] == 1
      breadcrumb :campsites
    else
      breadcrumb :campsites_pagination, params[:page]
    end
  end

  # # ogp画像の設定
  # def og_image(page_image = '')
  #   base_image = "https://camp-hood.s3.ap-northeast-1.amazonaws.com/uploads/ogp/ogp_image.png"
  #   if page_image.empty?
  #     base_image
  #   else
  #     page_image
  #   end
  # end

  # meta-tags設定
  def default_meta_tags
    {
      site: 'CAMPHOOD',
      title: '無料キャンプ場をもっと身近に利用しよう',
      charset: 'utf-8',
      description: '全国の無料キャンプ場を検索できて、周辺施設や天気を案内するサービス',
      keywords:    "CAMP,無料キャンプ場,BBQ,キャンプ,キャンプ飯",
      canonical: request.original_url, # 優先されるurl
      # noindex: ! Rails.env.production?, # 本番環境以外はnoindex
      icon: { href: image_url('favicon.ico') },
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp_image.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@42_ogi',
        image: image_url('ogp_image.png'),
      },
      fb: {
        app_id: Rails.application.credentials.dig(:sorcery, :facebook, :key),
      }
    }
  end

  # def campsite_count
  #   Campsite.all.ids.count
  # end
  # h6 class="mt-4 mb-3"><%= "無料キャンプ場は全国に#{campsite_count}件あります" %>/h6>

end
