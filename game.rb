require 'pry'

class RockPaperScissors
  attr_accessor :computer, :player, :computer_result, :player_result, :game_status
  def initialize(params = {})
    @computer = rand(3) + 1
    @player = params
    @computer_result = 0
    @player_result = 0
    @game_status = []
  end

  def player_number
    if !@player.nil?
      if !@player.empty?
        if @player["player"] == "rock"
          @player = 1
        elsif @player["player"] == "paper"
          @player = 2
        else
          @player = 3
        end
      else
        @game_status << "Please click a button."
        @player = 0
      end
    else
      @player = 0
    end
  end


  def player_status
    if @player == 1
      @game_status << "player chose rock."
    elsif @player == 2
      @game_status << "player chose paper."
    else
      @game_status << "player chose scissors."
    end
  end

  def computer_status
    if @computer == 1
      @game_status << "computer chose rock."
    elsif @computer == 2
      @game_status << "computer chose paper."
    else
      @game_status << "computer chose scissors."
    end
  end

  def game_result
    if (@player - 1 == @computer) ||
      (@player + 2 == @computer)
      @player_result += 1
      @game_status << "Player wins the round."
    elsif (@computer - 1 == @player) ||
      (@computer + 2 == @player)
      @computer_result += 1
      @game_status << "Computer wins the round."
    elsif
      @player == @computer
      @game_status << "Tie! Choose again."
    end
  end

  def play
    @computer = rand(3) + 1
    player_number
    if game_status[0] != "Please click a button."
      player_status
      computer_status
      game_result
      game_status
    else
      game_status
    end
  end
end
