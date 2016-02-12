require 'rails_helper'

# As a performer, I should be able to see who has booked one of my shows and confirm or refuse
# booking requests, so that user who have booked with me know if I’m available or not

feature 'Booking flow for performer' do

  scenario 'link to My Performances page' do
    user = FactoryGirl.create(:user)
    show = create :show, user: user
    bookings = create_list(:booking, 2, show: show, user: user, status: 1, date: 1.day.from_now)

    # When logged in and on homepage, performer can click on his name on the upper-right corner and select in the pop-up “Mes performances”
    signin(user.email, user.password)
    click_link "My Performances"

    #
    expect(page).to have_css('.performance', count: 2)
  end

end
