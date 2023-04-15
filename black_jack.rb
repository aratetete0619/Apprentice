require 'debug'

class Blackjack

  def initialize

    # 引いたカードの種類
    @type = ""

    # 引いたカードの数字
    @number = 0

    # 全プレイヤーの引いたカードの合計結果
    @result_of_dealing_cards = {}

    # 掛け金に関する特殊ルール
    @doubling =[]
    @splitting = []
    @surrender = []


  end


  def start
    ### CPUの数を設定
    puts "対戦したいCPUの数(0~2人)を指定してください"
    number_of_opponents = gets.chomp.to_i
    cpu_players = Cpu.new(number_of_opponents)

    ### プレイヤーとディーラーを作成
    player = Player.new
    dealer = Dealer.new

    puts "ブラックジャックを開始します"

    ### カードを各プレイヤーに2枚配布
    2.times do

      ### プレイヤーへのカードを配布
      dealing_cards
      player.drawing_cards(@type, @number)
      puts "#{player.name}の引いたカードは#{@type}の#{@number}です"


      ### CPUへのカードを配布
      cpu_players.each do |cpu_player|
        dealing_cards
        cpu_player.drawing_cards(@type, @number)
      end

    end

    ### プレイヤーが特殊ルールを選択できるか判定
    loop do
      puts "特殊ルールを選択しますか？(1:ダブリング, 2:スプリット, 3:サレンダー)"
      puts "現在の#{player.name}の所持チップ数は#{player.having_chips}です。"
      number_of_rule = gets.chomp.to_i
      select_special_rule(number_of_rule, player)

      break if (1..3).include?(number_of_rule)
    end

    ### ディーラーへのカードを配布
    dealing_cards

    ### 引いたカードをディーラークラスのデータとして保存(以下流れは同様)
    dealer.drawing_cards(@type, @number)
    puts "#{dealer.name}の引いたカードは#{@type}の#{@number}です"

    dealing_cards
    ### ディーラーの2枚目のカードはゲーム投了時に表示するために保存
    type_at_second_by_dealer = @type
    number_at_second_by_dealer = @number

    dealer.drawing_cards(@type, @number)
    puts "#{dealer.name}の引いた2枚目のカードはわかりません。"

    ### プレイヤーがカードを引くか選択肢を与える
    loop do
      puts "あなたの現在の得点は#{player.having_points}です。カードを引きますか？（Y/N）"
      answer = gets.chomp

      if answer == "Y" # プレイヤーがYesと答えた場合
        dealing_cards
        player.cards(@type, @number)
        puts "あなたの引いたカードは#{@type}の#{@number}です。"

        if player.having_points > 21 # 合計が21を超えたらループを抜けて終了
          puts "あなたの現在の得点は#{player.having_points}です。"
          puts "あなたの負けです。"
          exit
        end
      else # プレイヤーがNOと答えた場合
        break
      end
    end
    @result_of_dealing_cards[player.name] = player.having_points


    ### CPUがカードを引くか選択肢を与える
    cpu_players.each do |cpu_player|
      if cpu_player.having_points < 21
        puts "#{cpu_player.name}のターンです。もう少しお待ちください。"
        sleep(3)
        rand(0..2).times do
          dealing_cards
          cpu_player.drawing_cards(@type, @number)
          puts "#{cpu_player.name}の引いたカードは#{@type}の#{@number}です。"


          break if cpu_player.having_points > 21  # 合計が21を超えたらループを抜けて終了
        end
        if cpu_player.having_points <= 21
          @result_of_dealing_cards[cpu_player.name] = cpu_player.having_points
        else
          @result_of_dealing_cards.delete(cpu_player.name)
        end
      end
    end

    ### ディーターの引いた２枚目のカードをプレイヤーに告示
    puts "ディーラーの引いた2枚目のカードは#{type_at_second_by_dealer}の#{number_at_second_by_dealer}でした。"
    puts "ディーラーの現在の得点は#{dealer.having_points}です。"

    ### ディーラーがカードを引くか選択肢を与える
    if @dealer.having_points < 17
      15.times do
        dealing_cards
        @dealer.cards(@type, @number)
        puts "ディーラーの引いたカードは#{@type}の#{@number}です。"

        if @dealer.having_points > 21  # 合計が21を超えたらゲーム終了
          puts "プレイヤー全員の勝ちです"
          exit
        end
        break if @dealer.having_points >= 17 #合計が17を超えたらディーラーはカードを引き終える
      end
    end
    @result_of_dealing_cards[dealer.name] = @dealer.having_points

    ### プレイヤー、ディーラー、CPUの結果を表示
    winners = winners(dealer)
    drawers = drawers(dealer)

    if winners.any?
      puts "#{winners.keys.join("と")}の勝ちです。"
      puts "#{player.name}の負けです。" unless winners.keys.include?(player.name) || drawers.keys.include?(player.name)
      puts "#{player.name}は引き分けです。" if drawers.keys.include?(player.name)
    elsif drawers.any?
      puts "#{drawers.keys.join("と")}は引き分けです。" if drawers.keys.any?
      puts "#{player.name}の負けです。" unless winners.keys.include?(player.name)
    elsif winners.empty? && drawers.empty?
      puts "#{dealer.name}の勝ちです。"
    end

    puts "ブラックジャックを終了します"

  end

  ### ここからはゲーム内のアクションとしてメソッドを定義 ###

  ### カードが配布された時のメソッド
  def dealing_cards
    cards = Card.new # カードオブジェクトの生成

    card = cards.drew  # ランダムにカードを引く

    @type = card.keys.flatten.sample  # カードの種類を保存

    @number = card.values.flatten.sample # カードの数字を保存
  end


  ### プレイヤーに勝者がいる場合(ディーラーよりも点数が高い)
  def winners(dealer)
    return @result_of_dealing_cards.select{ |key, value| value > @result_of_dealing_cards[dealer.name] }
  end

  ### プレイヤーに引き分けがいる場合(ディーラーと同点)
  def drawers(dealer)
    @result_of_dealing_cards.select{ |key, value| value == @result_of_dealing_cards[dealer.name] }.delete(@dealer.name) # ディーラーに対しての比較なので要素からディーラーは削除
  end


  ### 特殊ルールが選択された時のメソッド
  def select_special_rule(num, player)
    if number_of_rule == 1  # ダブリングが選択された場合
      doubling(player)
    elsif number_of_rule == 2  # スプリットが選択された場合
      if player.having_cards.map(&:values).flatten.uniq.length == 1 #2枚のカードの値が同様であれば、uniqで重複を削除した配列の長さは1になる
        split(player)
      else
        raise("あなたの手札ではスプリットが出来ません。")
      end
    elsif number_of_rule == 3 # サレンダーが選択された場合
      surrender(player)
    end
  end

  # ダブリングが選択された時のメソッド
  def doubling(player)
    @doubling << player.name
  end

  # スプリットが選択された時のメソッド
  def split(player)
    @split << player.name
  end

  # サレンダーが選択された時のメソッド
  def surrender(player)
    @surrender << player.name
  end


end

# 継承元のクラス(クラス名がしっくりこないので変えた方がいいかもしれない、、、)
# 継承先は、ディーラー、プレイヤー、CPUを想定
class Person
  attr_accessor :name
  attr_reader :chips # チップが不正に変更されるのを防ぐため読み取り専用とする

  def initialize(num=nil)
    @chip = Chip.new
  end

  def having_chips
    @chip.chips
  end


  # 引いたカードのデータを保存
  def drawing_cards(type, number)

    # カードの種類と数字をセットにするためにハッシュ化
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

    # A、J、Q、Kなどの特殊点数のための場合分け
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
end

class Player < Person
  def initialize
    super
    @name = "あなた"
  end
end

class Cpu < Person

  def initialize(num)
    super
    i = 0
    @cpu_players = []
    num.times do |i|
      i += 1
      cpu_player = "CPU#{i}"
      @cpu_players << cpu_player
    end
    return @cpu_players
  end

end

class Card
  attr_reader :number_of_cards, :cards

   def initialize

    # カードの総数
    @number_of_cards = 52

    # カードの種類
    @cards = [{"ハート" => [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K]},
              {"ダイヤ" =>  [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K]},
              {"スペード" =>  [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K]},
              {"クローバー" =>  [:A,2,3,4,5,6,7,8,9,10,:J,:Q,:K]}]

   end

   def drew
    @cards.sample
    @number_of_cards -= 1 # カードの総数から1枚引いたことにする
   end
end

class Chip
  attr_accessor :chips

  def initialize
    @chips = 100
  end

end

blackjack = Blackjack.new
blackjack.start
