# require 'rails_helper'

# feature "Profile - Received comments" do

#   scenario "Visit" do
#     password = "123"*3
#     user = create(:user, password: password)
#     show = create(:show, user: user)

#     user_with_comments = create(:user_with_picture)
#     booking = create(:booking, show: show, user: user_with_comments)
#     review = create(:review, booking: booking)

#     signin(user.email, password)

#     visit profile_dashboard_path

#     expect(page).to have_css("img[src='#{user_with_comments.picture.image.url(:thumb)}']")
#     expect(page).to have_content(user_with_comments.full_name)
#   end


# end
