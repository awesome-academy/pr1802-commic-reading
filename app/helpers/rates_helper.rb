module RatesHelper
  def options_for_select_rating
    (1..5).map &:to_s
  end
end
