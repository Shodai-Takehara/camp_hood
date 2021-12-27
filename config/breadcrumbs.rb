crumb :root do
  link '<i class="fas fa-home"></i>トップ&nbsp;'.html_safe, root_path
end

crumb :campsites do
  link "&nbsp;キャンプ場一覧&nbsp;".html_safe, campsites_path
  parent :root
end

crumb :campsites_pagination do |page|
  link "&nbsp;#{page}ページ目&nbsp;".html_safe, campsites_path(params[:page])
  parent :campsites
end

crumb :campsite do |campsite|
  campsite = Campsite.find(params[:id])
  link "&nbsp;#{campsite.name}の詳細&nbsp;".html_safe,  campsite_path(campsite)
  parent :campsites
end

crumb :mypage do |user|
  link "&nbsp;#{current_user.name}さんのページ&nbsp;".html_safe, mypage_campsites_path(user)
  parent :campsites
end

crumb :guidance do |campsite|
  link "&nbsp;詳細案内".html_safe
  parent :campsite
end

# crumb :login do
#   link "ログイン", login_path
#   parent :root
# end

# crumb :edit_password_resets do
#   link "パスワードリセット", new_password_reset_path
#   parent :login
# end

# crumb :new_user do
#   link "ユーザー登録", new_user_path
#   parent :root
# end

# crumb :edit_profile do |user|
#   link "プロフィール編集", edit_profile_path(user)
#   parent :mypage
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
