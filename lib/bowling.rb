class Bowling

  def initialize
    @total_score = 0
    @scores =[]
    @temp =[]
    # フレームごとの合計を格納する配列
    @frame_score = []
  end

  def total_score
    @total_score
  end

  def add_score(pins)
    @temp << pins
    if @temp.size == 2 || strike?(@temp)
      @scores << @temp
      @temp = []
    end
  end

  def calc_score
    @scores.each.with_index(1) do |score, index|
      # 最終フレーム以外でのストライクなら、スコアにボーナスを含めて合計する
      if strike?(score) && not_last_frame?(index)
        # 次のフレームもストライクで、なおかつ最終フレーム以外なら、
        # もう一つ次のフレームの一投目をボーナスの対象にする
        @total_score += calc_strike_bonus(index)
        # 最終フレーム以外でのスペアなら、スコアにボーナスを含めて合計する
      elsif spare?(score) && not_last_frame?(index)
        @total_score += calc_spare_bonus(index)
      else
        @total_score += score.inject(:+)
      end

      @frame_score << @total_score
    end
  end

  def frame_score(frame)
    @frame_score[frame - 1]
  end

  private
    def spare?(score)
      score.inject(:+) == 10
    end

    def strike?(score)
      score.first == 10
    end

    def not_last_frame?(index)
      index < 10
    end

    def calc_spare_bonus(index)
      10 + @scores[index].first
    end

    def calc_strike_bonus(index)
      if strike?(@scores[index]) && not_last_frame?(index + 1)
        20 + @scores[index + 1].first
      else
        10 + @scores[index].inject(:+)
      end
    end
end