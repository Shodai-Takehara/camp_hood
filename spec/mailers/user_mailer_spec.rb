require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { build(:user) }
  describe 'ActionMailerの送信' do
    context '登録お礼メールの確認' do
      it '指定したアドレスからメールが送信されていること' do
        UserMailer.with(name: user.name, to: user.email).welcome.deliver_now
        expect(ActionMailer::Base.deliveries.last.from.first).to eq ('camphood.freesite@gmail.com')
      end

      it '指定した送信先のアドレスであること' do
        UserMailer.with(name: user.name, to: user.email).welcome.deliver_now
        expect(ActionMailer::Base.deliveries.last.to.first).to eq (user.email)
      end

      it '正常にメールが送信されていること' do
        UserMailer.with(name: user.name, to: user.email).welcome.deliver_now
        expect(ActionMailer::Base.deliveries.last.subject).to eq ('ご登録ありがとうございます。')
      end
    end
  end
end
