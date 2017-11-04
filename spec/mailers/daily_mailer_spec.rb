require "rails_helper"

RSpec.describe DailyMailer, type: :mailer do
  describe "digest" do
    let(:user) { create(:user) }
    let(:mail) { DailyMailer.digest(user) }
    let(:questions) { create_list(:question, 5) }

    it "renders the headers" do
      expect(mail.subject).to eq("Digest")
      expect(mail.from).to eq(["from@example.com"])
    end

    it 'sends notification for user email'do
      expect(mail.to).to eq [user.email]
    end

    it "renders the questions" do
      questions.each do |question|
        expect(mail.body.encoded).to match question.title
      end
    end
  end
end
