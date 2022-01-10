module LoginMacros
  def login_as(user)
    visit root_path
    click_link 'ログイン'
    fill_in 'emailfield', with: user.email
    fill_in 'passwordfield', with: 'password'
    click_button 'ログイン'
  end
end
