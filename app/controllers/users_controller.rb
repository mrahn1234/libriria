class Users::SessionsController < Devise::SessionsController
   # def after_sign_up_path_for(resource)
   #    redirect root_url
   #  end
   def create
   	   super

   end
end