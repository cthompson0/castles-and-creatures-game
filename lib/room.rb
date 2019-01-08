class Room
  attr_accessor :name, :monster, :win_chance, :treasure, :points

  def initialize(data)
    @name = data["name"]
    @monster = data["monster"]["name"]
    @win_chance = data["monster"]["win_chance"]
    @treasure = data["treasure"]["type"]
    @points = data["treasure"]["points"]
  end

  def room_phase
    puts "You come across a #{@name}."
  end

  def monster_phase
    puts "#{@monster} jumps out in front of you!"
  end

  def monster_fight_win_text
    puts "You successfully defeated the #{@monster}!"
    puts "You find a #{@treasure} clutched in a hand of the now lifeless #{@monster}."
    puts "You quickly put it into your pouch. (+#{@points} pts!)"
  end

  def monster_fight_fail_text
    puts "The #{@monster} has defeated you."
    puts "*" * 25
  end

  def monster_bluff_win_text
    puts "You successfully scare the #{@monster} and cause them to flee!"
    puts "You find a #{@treasure} on the floor where the #{@monster} was standing."
    puts "You quickly put it into your pouch. (+#{@points} pts!)"
  end

  def monster_bluff_fail_text
    puts "Your attempts to scare #{@monster} have failed!"
    puts "Looks like you will have to fight your way out!"
  end

  def fight_successful?
    rand(100) < @win_chance
  end
end
