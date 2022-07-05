class SessionsController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def create                  #what's the difference between this create and the Create function in User?
        @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])    #what are these params actually doing? Are we doing params[:user] because we're not in the Users controller?

        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            render :new
        end

    end

    def destroy
      logout!
      redirect_to new_session_url
    end

    

end
