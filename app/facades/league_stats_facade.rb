class LeagueStatsFacade
  def quarterbacks
    top_6('QB')
  end

  def running_backs
    top_6('RB')
  end

  def wide_receivers
    top_6('WR')
  end

  def tight_ends
    top_6('TE')
  end

  def kickers
    top_6('K')
  end

  def defenses
    top_6('DEF')
  end

  private

  def top_6(pos)
    Player.current_top_6(pos)
  end
end
