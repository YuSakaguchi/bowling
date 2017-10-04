require 'bowling'

describe "ボウリングのスコア計算" do

  before do
    @game = Bowling.new
  end

  describe "全体の合計" do
    context "全ての投球がガーターだった場合" do
      it "0になること" do
        add_many_scores(20,0)
        @game.calc_score
        expect(@game.total_score).to eq 0
      end
    end

    context "全ての投球で１ピンずつ倒した場合" do
      it "20" do
        add_many_scores(20,1)
        @game.calc_score
        expect(@game.total_score).to eq 20
      end
    end
  end

  context "スペアを撮った場合" do
    it "スペアボーナスが加算されること" do
      # 1
      @game.add_score(3)
      @game.add_score(7)
      # 2
      @game.add_score(4)

      add_many_scores(17,0)

      @game.calc_score
      expect(@game.total_score).to eq 18
    end
  end

  context "最終フレームでスペアを取った場合" do
    it "スペアボーナスが加算されないこと" do
      @game.add_score(3)
      @game.add_score(7)
      @game.add_score(4)

      add_many_scores(15,0)
      #final
      @game.add_score(3)
      @game.add_score(7)

      @game.calc_score

      expect(@game.total_score).to eq 28
    end

  end

  private
    def add_many_scores(count,pins)
      count.times do
        @game.add_score(pins)
      end
    end
end
