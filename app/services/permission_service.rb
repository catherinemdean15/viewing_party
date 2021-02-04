class PermissionService
  def initialize(user, controller, action)
    @user = user || User.new
    @controller = controller
    @action = action
  end

  def authorized?
    if user.is_registered?
      registered_permissions
    else
      regular_permissions
    end
  end

  private

  attr_reader :user, :controller, :action

  def registered_permissions
    return true if controller == 'welcome' && action == 'index'
    return true if controller == 'users' && action.in?(%w[new create destroy dashboard])
    return true if controller == 'sessions' && action.in?(%w[new create destroy])
  end

  def regular_permissions
    return true if controller == 'welcome' && action == 'index'
    return true if controller == 'users' && action.in?(%w[new create])
    return true if controller == 'sessions' && action.in?(%w[new create destroy])
  end
end
