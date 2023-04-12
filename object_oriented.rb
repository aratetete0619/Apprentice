class VendingMachine

  def initialize(manufacturer = nil)
    @manufacturer = manufacturer
    @drinks = {cider: 100, cola: 150, hot_cup_coffee: 100, ice_cup_coffee: 100, potato_chips: 100}
    @coin = 0
    @cups = 100
    @having_cup = false
  end

  def press_button(drink)
    ## ドリンク分のお金を持っているか判定
    return nil unless @coin >= @drinks[drink.name]
    ## ドリンクが在庫にあることとカップを持っているかを判定
    if drink.name == :hot_cup_coffee || drink.name == :ice_cup_coffee
      return nil unless @having_cup && @cups > 0
      @having_cup = false
    end
    @coin -= @drinks[drink.name]
    return drink.name.to_s
  end

  def deposit_coin(coin)
    @coin += coin if coin == 100
  end

  def add_cup(cup)
    @cups -= cup
    @having_cup = true
  end

  private

  def press_manufacturer_name
    @manufacturer
  end
end

class Item
  def initialize(item = nil)
    @item = item.to_sym
  end

  def name
    @item
  end
end

class Drink < Item
end


class CupCoffee < Item
  def initialize(item)
    super item
    @item = :hot_cup_coffee if @item == :hot
    @item = :ice_cup_coffee if @item == :ice
  end
end

class Snack < Item
  def initialize
    @item = :potato_chips
  end
end


hot_cup_coffee = CupCoffee.new('hot')
cider = Drink.new('cider')
snack = Snack.new
vending_machine = VendingMachine.new('サントリー')
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(cider)

puts vending_machine.press_button(hot_cup_coffee)
vending_machine.add_cup(1)
puts vending_machine.press_button(hot_cup_coffee)

puts vending_machine.press_button(snack)
vending_machine.deposit_coin(100)
vending_machine.deposit_coin(100)
puts vending_machine.press_button(snack)
