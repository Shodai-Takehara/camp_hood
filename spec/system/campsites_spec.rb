require 'rails_helper'

RSpec.describe "Campsites", type: :system do
  describe 'キャンプ場一覧画面' do
    it 'トップ > キャンプ場一覧というぱんくずが表示されていること' do
      visit campsites_path
      within('.breadcrumb') do
        expect(page).to have_content('トップ')
        expect(page).to have_content('キャンプ場一覧')
      end
    end

    it 'トップをクリックしたらトップページに遷移すること' do
      visit campsites_path
      within('.breadcrumb') do
        click_link 'トップ'
      end
      expect(current_path).to eq(root_path)
    end
  end

  describe 'トップページからの遷移' do
    context 'ログイン前' do
      it '新規登録画面への遷移' do
        visit root_path
        click_link '新規登録'
        expect(current_path).to eq(new_user_path)
      end

      it 'ログイン画面への遷移' do
        visit root_path
        click_link 'ログイン'
        expect(current_path).to eq(login_path)
      end

      it 'パスワードリセット画面への遷移' do
        visit login_path
        click_link 'パスワードをお忘れの方はこちら'
        expect(current_path).to eq(new_password_reset_path)
      end
    end

    context 'ログイン後' do
      let(:user) { create(:user) }
      it 'ログアウト処理が成功する' do
        login_as(user)
        click_link 'ログアウト'
        expect(page.driver.browser.switch_to.alert.text).to eq "ログアウトしますか？"
        page.driver.browser.switch_to.alert.accept
        expect(current_path).to eq(root_path)
        expect(page).to have_content 'ログアウトしました'
      end

      it 'マイページへの遷移が完了し、ぱんくずが表示されている' do
        login_as(user)
        click_link 'マイページ'
        expect(current_path).to eq(mypage_campsites_path)
        within('.breadcrumb') do
          expect(page).to have_content('トップ')
          expect(page).to have_content('キャンプ場一覧')
          expect(page).to have_content('さんのページ')
        end
      end

      it 'ユーザー編集ページへ遷移する' do
        login_as(user)
        click_link 'マイページ'
        click_link '編集する'
        expect(current_path).to eq(edit_profile_path)
      end

      it 'マイページからぱんくずを使ってキャンプ場一覧へ遷移する' do
        login_as(user)
        visit mypage_campsites_path
        click_link 'キャンプ場一覧'
        expect(current_path).to eq(campsites_path)
      end
    end
  end

  describe 'ユーザー編集のテスト' do
    let(:user) { create(:user) }
    before do
      login_as(user)
      visit mypage_campsites_path
      click_link '編集する'
    end
    context 'ユーザー編集が成功する' do
      it '名前を編集する' do
        fill_in 'user_name', with: 'hogehoge'
        click_button '更新する'
        expect(current_path).to eq(mypage_campsites_path)
        expect(page).to have_content('更新が完了しました')
      end

      it 'メールアドレスを編集する' do
        fill_in 'user_email', with: 'test2022@example.com'
        click_button '更新する'
        expect(current_path).to eq(mypage_campsites_path)
        expect(page).to have_content('更新が完了しました')
      end

      xit 'アバター画像を編集する' do
        click_button '更新する'
        expect(current_path).to eq(mypage_campsites_path)
        expect(page).to have_content('更新が完了しました')
      end
    end

    context 'ユーザー編集が失敗する' do
      it '名前を20文字以上で編集して失敗する' do
        fill_in 'user_name', with: 'hogehogehogehogehogeh'
        click_button '更新する'
        expect(current_path).to eq(profile_path)
        expect(page).to have_content('更新に失敗しました')
        expect(page).to have_content('ニックネームは20文字以内で入力してください')
      end

      it '登録済みメールアドレスで編集して失敗する' do
        users = create_list(:user, 2)
        fill_in 'user_email', with: users[1].email
        click_button '更新する'
        expect(current_path).to eq(profile_path)
        expect(page).to have_content('更新に失敗しました')
        expect(page).to have_content('メールアドレスはすでに存在します')
      end

      xit 'ホワイトリスト以外のデータでアバター画像を編集する' do
        click_button '更新する'
        expect(current_path).to eq(profile_path)
        expect(page).to have_content('更新に失敗しました')
      end
    end
  end

  describe 'ユーザー削除のテスト' do
    let(:user) { create(:user) }
    it 'ユーザー削除が成功する' do
      login_as(user)
      visit mypage_campsites_path
      click_link '編集する'
      click_on '退会する'
      expect(page.driver.browser.switch_to.alert.text).to eq "退会するとデータは全て削除されます。退会しますか？"
      page.driver.browser.switch_to.alert.accept
      expect(current_path).to eq(root_path)
      expect(page).to have_content('退会しました')
    end
  end
end
