require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { build(:user) }
  before do
    ActionMailer::Base.deliveries.clear
  end

  describe 'ActionMailerの送信' do
    context '登録お礼メールの確認' do
      it '指定したアドレスからメールが送信されていること' do
        UserMailer.with(name: user.name, to: user.email).welcome.deliver_now
        expect(ActionMailer::Base.deliveries.last.from.first).to eq('camphood.freesite@gmail.com')
      end

      it '指定した送信先のアドレスであること' do
        UserMailer.with(name: user.name, to: user.email).welcome.deliver_now
        expect(ActionMailer::Base.deliveries.last.to.first).to eq(user.email)
      end

      it '正常にメールが送信されていること' do
        UserMailer.with(name: user.name, to: user.email).welcome.deliver_now
        expect(ActionMailer::Base.deliveries.last.subject).to eq('ご登録ありがとうございます。')
      end
    end

    xcontext 'パスワードリセット処理' do
      let(:mail) { UserMailer.reset_password_email(user) }
      # Base64 encodeをデコードして比較できるようにする
      let(:mail_body) { mail.body.encoded.split(/\r\n/).map { |i| Base64.decode64(i) }.join }

      it 'ヘッダーが正しく表示されること' do
        user.reset_password_token = User.reset_password_token(user.id)
        expect(mail.to).to eq(user.email)
        expect(mail.from).to eq('camphood.freesite@gmail.com')
        expect(mail.subject).to eq('パスワードリセット')
      end

      # メールプレビューのテスト
      it 'メール文が正しく表示されること' do
        user.reset_token = User.new_token
        expect(mail_body).to match user.reset_token
        expect(mail_body).to match CGI.escape(user.email)
      end
    end
  end
end
