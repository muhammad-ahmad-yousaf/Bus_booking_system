module Users
  class RegistrationsController < Devise::RegistrationsController
    def destroy
      if resource.bookings.exists?
        redirect_to edit_user_registration_path,
                    alert: "⚠️ You can’t delete your account because you have existing bookings."
      else
        super
      end
    end
  end
end
