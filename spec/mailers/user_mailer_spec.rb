require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  include ActionView::Helpers::NumberHelper

  context '#booking_cancelled' do
    let(:user) { create :user }
    let(:show) { create :show }
    let(:booking) { create :booking, user: user, show: show }

    subject { UserMailer.booking_cancelled(booking) }

    it { expect(subject.to).to eq [ booking.user.email ] }
    it { expect(subject.body.encoded).to include(booking.show.title) }
  end

  context '#booking_accepted' do
    let(:user) { create :user }
    let(:user2) { create :user }
    let(:show) { create :show, user: user2 }
    let(:booking) { create :booking, user: user, show: show }

    subject { UserMailer.booking_accepted(booking) }

    it { expect(subject.to).to eq [ booking.user.email ] }
    it { expect(subject.body.encoded).to include(booking.show.title) }
    it { expect(subject.body.encoded).to include(booking.show.length.to_s) }
    it { expect(subject.body.encoded).to include(booking.show.user.full_name) }
    it { expect(subject.body.encoded).to include(booking.show.user.phone_number) }
    it { expect(subject.body.encoded).to include(I18n.l(booking.date, format: :long)) }
    it { expect(subject.body.encoded).to include(number_to_currency booking.price) }
    it { expect(subject.body.encoded).to include(booking.spectators.to_s) }
    it { expect(subject.body.encoded).to include(booking.user.addresses.first.full_address) }
  end

end
