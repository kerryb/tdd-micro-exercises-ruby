require "ticket_dispenser"

describe TicketDispenser do
  subject { described_class.new turn_number_generator: turn_number_generator }
  let(:turn_number_generator) { double :turn_number_generator, call: 123 }

  it "issues a ticket with the correct number" do
    expect(subject.get_turn_ticket.turn_number).to eq 123
  end
end
