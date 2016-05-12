class CreateAdminService
  def perform
    User.find_or_create_by!(email: Rails.application.secrets.admin_email,
                            firstname: 'Admin', surname: 'Admin', gender: 1,
                            phone_number: '123-456-7890') do |user|
      user.password = Rails.application.secrets.admin_password
      user.password_confirmation = Rails.application.secrets.admin_password
      user.role = 0
    end
  end
end
