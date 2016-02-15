require "rails_helper"

RSpec.describe PerformerMailer, type: :mailer do

  context '#booking_cancelled' do
    let(:user) { create :user }
    let(:user2) { create :user }
    let(:show) { create :show, user: user }
    let(:booking) { create :booking, show: show, user: user2 }

    subject { PerformerMailer.booking_cancelled(booking) }

    it { expect(subject.to).to eq [ booking.show.user.email ] }
    it { expect(subject.subject).to eq I18n.t('performer_mailer.booking_cancelled.subject') }
    it { expect(subject.body.encoded).to include(booking.show.title) }
    it { expect(subject.body.encoded).to include(booking.user.full_name) }
  end

end
