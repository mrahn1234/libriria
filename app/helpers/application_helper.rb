module ApplicationHelper
  include Pagy::Frontend
  
  def full_title(page_title = '')
    base_title = "Rails LibraryVLC"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def cart
      @cart = Cart.where(user_id: current_user.id).last if current_user 
      if @cart 
        return @cart
      else 
        return nil
      end
  end

  def requests 
    @cart = cart
    if  @cart.nil? || @cart.verify != 3
      return nil 
    else
      @requests = Request.where(cart_id: @cart.id)
      return @requests
    end
  end

  def check_status (cart)
      if cart.verify == 0 
        return "Pending"
      elsif cart.verify == 1 
        return "Accept"
      elsif cart.verify == 2
        return "Decline"
      end
  end
  
end
