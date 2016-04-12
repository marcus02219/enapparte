# require 'rails_helper'

# # As a performer, I should be able to see who has booked one of my shows and confirm or refuse
# # booking requests, so that user who have booked with me know if I’m available or not

# feature 'Booking flow for performer' do
#   let(:show) { create :show, user: user }
#   let(:user) { FactoryGirl.create(:user) }
#   let!(:booking) { create(:booking, show: show, user: user, status: 1, date: 1.day.from_now) }
#   let!(:pending_booking) { create(:booking, show: show, user: user, status: 2, date: 1.day.from_now) }

#   before(:each) do
#     signin(user.email, user.password)
#     page.find('#dropdownMenu1').click
#     click_link "My Performances"
#   end

#   scenario 'link to My Performances page', js: true do
#     expect(page).to have_css('.performance', count: 2)
#   end

#   # # As a performer, I should be able to accept booking requests,
#   # # so I can let the booker now I’m available to perform at his place
#   # scenario 'Performer accepts booking flow', js: true do
#   #   within "#performance_#{pending_booking.id}" do
#   #     click_button 'Accept the application'
#   #   end
#   # end

# end
