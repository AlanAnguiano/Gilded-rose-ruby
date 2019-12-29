class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      ItemDecorator.choose(item).update
    end
  end
end

class ItemDecorator < SimpleDelegator
  def self.choose(item)
    case item.name
    when "Aged Brie"
      AgedBrie.new(item)
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePass.new(item)
    when "Conjured Mana Cake"
      ConjuredItem.new(item)
    when "Sulfuras, Hand of Ragnaros"
      SulfurasItem.new(item)
    else
      new(item)
    end
  end

  def update
    return if name == "Sulfuras, Hand of Ragnaros"

    age
    update_quality
  end

  def age
    self.sell_in -= 1
  end

  def update_quality
    self.quality += calculate_quality_adjustment
  end

  def calculate_quality_adjustment
    adjustment = 0

    if sell_in < 0
      adjustment -= 1
    else
      adjustment -= 1
    end

    adjustment
  end

  def quality=(new_quality)
    new_quality = 0 if new_quality < 0
    new_quality = 50 if new_quality > 50
    super(new_quality)
  end
end

class AgedBrie < ItemDecorator
  def calculate_quality_adjustment
    adjustment = 1
    if sell_in < 0
      adjustment += 1
    end

    adjustment
  end
end

class BackstagePass < ItemDecorator
  def calculate_quality_adjustment
    adjustment = 1
    if sell_in < 11
      adjustment += 1
    end
    if sell_in < 6
      adjustment += 1
    end
    if sell_in < 0
      adjustment -= quality
    end

    adjustment
  end
end

class ConjuredItem < ItemDecorator
  def calculate_quality_adjustment
    adjustment = -2
    if sell_in < 0
      adjustment -= 2
    end

    adjustment
  end
end

class SulfurasItem < ItemDecorator
  def calculate_quality_adjustment
    #NO cambia es legendario
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end