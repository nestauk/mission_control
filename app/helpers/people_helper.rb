module PeopleHelper
  def cell_bg_color(n)
    case n
    when 5..50
      'bg-red-100'
    when 4..5
      'bg-amber-100'
    when 2..4
      'bg-green-100'
    end
  end
end
