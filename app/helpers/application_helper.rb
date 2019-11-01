module ApplicationHelper
  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}
  end

  def player_positions
    [
      ['All', 'all'],
      ['Quarterback', 'QB'],
      ['Wide Receiver', 'WR'],
      ['Running Back', 'RB'],
      ['Kicker', 'K'],
      ['Tight End', 'TE'],
      ['Defense', 'DEF'],
    ]
  end
end
