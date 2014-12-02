require "alarm"

describe Alarm do
  let(:sensor) { double :sensor }
  subject { described_class.new sensor }

  it "turns the alarm on when the pressure is too low" do
    allow(sensor).to receive(:pop_next_pressure_psi_value) { Alarm::LOW_PRESSURE - 1 }
    subject.check
    expect(subject.alarm_on).to be_truthy
  end

  it "turns the alarm on when the pressure is too high" do
    allow(sensor).to receive(:pop_next_pressure_psi_value) { Alarm::HIGH_PRESSURE + 1 }
    subject.check
    expect(subject.alarm_on).to be_truthy
  end

  it "turns the alarm off when the pressure isn't quite too low" do
    allow(sensor).to receive(:pop_next_pressure_psi_value) { Alarm::LOW_PRESSURE }
    subject.check
    expect(subject.alarm_on).to be_falsy
  end

  it "turns the alarm off when the pressure isn't quite too high" do
    allow(sensor).to receive(:pop_next_pressure_psi_value) { Alarm::HIGH_PRESSURE }
    subject.check
    expect(subject.alarm_on).to be_falsy
  end

  it "turns the alarm back off when the pressure goes back into normal limits" do
    allow(sensor).to receive(:pop_next_pressure_psi_value) { Alarm::HIGH_PRESSURE + 1 }
    subject.check
    allow(sensor).to receive(:pop_next_pressure_psi_value) { Alarm::HIGH_PRESSURE }
    subject.check
    expect(subject.alarm_on).to be_falsy
  end
end
