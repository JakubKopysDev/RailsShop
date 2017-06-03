module TicketsHelper
  def default_value(input:)
    return '' unless current_user

    case input
      when :name then current_user.name
      when :email then current_user.email
      else ''
    end
  end
end
