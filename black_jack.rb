require 'debug'

class Blackjack

  def initialize

    # カードの総数
    @number_of_cards = 52

    # カードの種類
    @cards = [{"ハート" => [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K]},
              {"ダイヤ" =>  [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K]},
              {"スペード" =>  [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K]},
              {"クローバー" =>  [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K]}]

    # 引いたカードの種類
    @type = ""

    # 引いたカードの数字
    @number = 0

  end


  def start

    # プレイヤーとディーラーを作成
    player = Player.new
    dealer = Dealer.new

    puts "ブラックジャックを開始します"

    # プレイヤーのカードを表示
    2.times do

      # プレイヤーへのカードを配布
      dealing_cards

      # 引いたカードをプレイヤークラスのデータとして保存
      player.cards(@type, @number)
      puts "#{player.name}の引いたカードは#{@type}の#{@number}です"

    end

    # ディーラーへのカードを配布
    dealing_cards

    # 引いたカードをディーラークラスのデータとして保存(以下流れは同様)
    dealer.cards(@type, @number)
    puts "#{dealer.name}の引いたカードは#{@type}の#{@number}です"

    dealing_cards
    # ディーラーの2枚目のカードはゲーム投了時に表示するために保存
    type_at_second_by_dealer = @type
    number_at_second_by_dealer = @number

    dealer.cards(@type, @number)
    puts "#{dealer.name}の引いた2枚目のカードはわかりません。"

    # プレイヤーがカードを引く回数を考慮した繰り返し処理
    # ここではloop処理するか悩んだが、仮にプレイヤーがA(1点)を21回引いた最初数の場合を考えて最低限の繰り返し処理にするように考慮した
    21.times do

      # プレイヤーがカードを引くか選択肢を与える
      puts "あなたの現在の得点は#{player.having_points}です。カードを引きますか？（Y/N）"
      answer = gets.chomp

      # プレイヤーがYesと答えた場合
      if answer == "Y"
        dealing_cards
        player.cards(@type, @number)
        puts "あなたの引いたカードは#{@type}の#{@number}です。"

        # 合計が21を超えたら終了
        if player.having_points >= 21
          puts "あなたの現在の得点は#{player.having_points}です。"
          break
        end
      else # プレイヤーがNOと答えた場合
        break
      end
    end

    # ディーターの引いた２枚目のカードをプレイヤーに告示
    puts "ディーラーの引いた2枚目のカードは#{type_at_second_by_dealer}の#{number_at_second_by_dealer}でした。"
    puts "ディーラーの現在の得点は#{dealer.having_points}です。"


    # 勝敗結果
    if player.having_points > dealer.having_points
      puts "あなたの勝ちです。"
    elsif player.having_points < dealer.having_points
      puts "あなたの負けです。"
    else
      puts "引き分けです。"
    end

    puts "ブラックジャックを終了します"

  end

  # カードが配布された時のメソッド
  def dealing_cards

    # ランダムにカードを引く
    card = @cards.sample

    # カードの種類を保存
    @type = card.keys.flatten.sample

    # カードの数字を保存
    @number = card.values.flatten.sample

    # カードの総数から1枚引かれる
    @number_of_cards -= 1
  end



end

# 継承元のクラス(クラス名がしっくりこないので変えた方がいいかもしれない、、、)
# 継承先は、ディーラー、プレイヤー、CPUを想定
class Person
  attr_accessor :name

  # 引いたカードのデータを保存
  def cards(type, number)

    # カードの種類と数字をセットにするばめにハッシュ化
    card = {type => number}

    # @cardsがnilであれば空の配列を作る
    @cards ||= []

    # @cardsにカードを追加
    @cards << card

  end

  # 持っているカードが読み取れるメソッド
  def having_cards
    @cards
  end

  # 所持しているカードからポイントを算出
  def having_points
    points = 0

    @cards.each do |card|
      card.each do |type, num|
        case num
        when :A
          if points <= 10
            points += 11
          else
            points += 1
          end
        when :J, :Q, :K
          points += 10
        else
          points += num
        end
      end
    end

    return points
  end


end


class Dealer < Person

  def initialize
    @name = "ディーラー"
  end

  def cards(type, number)
    super
  end

end

class Player < Person

  def initialize
    @name = "あなた"
  end

  def cards(type, number)
    super
  end
end

blackjack = Blackjack.new
blackjack.start
