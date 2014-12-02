require_relative './turn_number_sequence'
require_relative './turn_ticket'

class TicketDispenser
  def initialize turn_number_generator: ->{ TurnNumberSequence.get_next_turn_number }
    @turn_number_generator = turn_number_generator
  end

  def get_turn_ticket
    new_turn_number = @turn_number_generator.call

    TurnTicket.new(new_turn_number)
  end
end
