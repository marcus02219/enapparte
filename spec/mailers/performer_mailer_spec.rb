require "rails_helper"

RSpec.describe PerformerMailer, type: :mailer do
  include ActionView::Helpers::NumberHelper

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

  context '#booking_accepted' do
    let(:user) { create :user }
    let(:user2) { create :user }
    let(:show) { create :show, user: user }
    let(:booking) { create :booking, show: show, user: user2 }

    subject { PerformerMailer.booking_accepted(booking) }

    it { expect(subject.to).to eq [ booking.show.user.email ] }
    it { expect(subject.subject).to eq I18n.t('performer_mailer.booking_accepted.subject') }
    it { expect(subject.body.encoded).to include(booking.show.title) }
    it { expect(subject.body.encoded).to include(booking.user.full_name) }
    it { expect(subject.body.encoded).to include(I18n.l booking.date, format: :long) }
    it { expect(subject.body.encoded).to include(number_to_currency booking.payout) }
    it { expect(subject.body.encoded).to include(booking.spectators.to_s) }
    it { expect(subject.body.encoded).to include(booking.user.addresses.first.full_address) }
    it { expect(subject.body.encoded).to include(booking.user.email) }
  end

end
