# require 'rails_helper'

# feature "Profile", :devise do
#   let(:user) { create(:user) }

#   scenario "Save" do
#     user_attributes = attributes_for(:user).reject { |k,v| %w(confirmed_at password email).include? k.to_s }
#     user_attributes.delete(:dob)
#     user_attributes.delete(:gender)

#     signin(user.email, '123'*3)

#     visit profile_dashboard_path

#     within '#personal' do
#       user_attributes.each do |attribute, value|
#         begin
#           fill_in "user_#{attribute.to_s}", with: value
#         rescue
#           begin
#             choose "user_#{attribute.to_s}", with: value
#           rescue
#             begin
#               page.find("#user_#{attribute.to_s}").select(value)
#             rescue
#               puts "Error fill form: #{attribute}"
#             end
#           end
#         end
#       end

#       click_button "Save My Profile"
#     end

#     user.reload
#     user_attributes.each do |attribute, value|
#       expect(user.send(attribute)).to eq(value), "expected #{attribute} eq #{value}, but #{user.send(attribute)}"
#     end
#   end

# end
