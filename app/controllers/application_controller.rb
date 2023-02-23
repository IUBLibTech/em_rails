class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def logged_in?
    if session[:user_id].blank?
      session[:forward] = request.url
      redirect_to signin_path
    end
  end

  def search
    @books = Book.solr_search(params[:searchField])
    render 'books/index'
  end

  def about
    render 'layouts/about'
  end

  def faq
    render "layouts/faq"
  end

  def contact
    render "layouts/contact"
  end

  def home
    @books = Book.where(featured: true).sample(4)
    @annotations = Annotation.where(sample: true).sample(4)
    render 'layouts/home'
  end

  def send_activation_email(user)

  end
  def send_reset_email(user)

  end

end
