class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook

    if current_user
      if current_user.facebook_connected?
        flash[:notice] = I18n.t('omniauth.facebook.already_linked')
      else
        if current_user.add_facebook_credentials(env["omniauth.auth"])
          flash[:notice] = I18n.t('omniauth.facebook.success')
        else
          flash[:alert] = I18n.t('omniauth.facebook.unable')
        end
      end
      redirect current_user, :event => :authentication and return
    end

    # You need to implement the method below in your model
    @login = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)
    if @login.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @login, :event => :authentication
    else
      session["devise.facebook_data"] = env["omniauth.auth"]
      redirect_to new_login_registration_url
    end
  end

end