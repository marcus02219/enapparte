require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  context '#booking_cancelled' do
    let(:user) { create :user }
    let(:show) { create :show }
    let(:booking) { create :booking, user: user, show: show }

    subject { UserMailer.booking_cancelled(booking) }

    it { expect(subject.to).to eq [ booking.user.email ] }
    it { expect(subject.body.encoded).to include(booking.show.title) }
  end

end
