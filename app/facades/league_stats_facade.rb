class LeagueStatsFacade
  def quarterbacks
    top_5('QB')
  end

  def running_backs
    top_5('RB')
  end

  def wide_receivers
    top_5('WR')
  end

  def tight_ends
    top_5('TE')
  end

  def kickers
    top_5('K')
  end

  def defenses
    top_5('DEF')
  end

  private

  def top_5(pos)
    Player.current_top_5(pos)
  end
end
