require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'ユーザー新規作成のテスト' do
    fit 'nameとemailとpassword,password再確認が入力されていればOK' do
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    context 'ユーザーネームに関するテスト' do
      it 'nameが空欄だとNG' do
        user.name = ""
        expect(user).not_to be_valid
      end

      it '名前が20文字以上だとNG' do
        user.name = "abcdabcdabcdabcdabcda"
        expect(user).not_to be_valid
        expect(user.errors[:name]).to include("は20文字以内で入力してください")
      end
    end

    it 'emailが空欄だとNG' do
      user.email = ""
      expect(user).not_to be_valid
    end

    context 'passwordに関するテスト' do
      it 'passwordが空欄だとNG' do
        user.password = ""
        expect(user).not_to be_valid
      end

      it 'password再確認が空欄だとNG' do
        user.password_confirmation = ""
        expect(user).not_to be_valid
      end

      it 'passwordとpassword再確認が一致しない場合NG' do
        user.password_confirmation = "pasword"
        expect(user).not_to be_valid
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
      end

      it 'passwordが6文字以下の場合NG' do
        user.password = "paass"
        user.password_confirmation = "paass"
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end
  end
end
