require_relative './sensor'

class Alarm
  LOW_PRESSURE = 17
  HIGH_PRESSURE = 21

  attr_reader :alarm_on

  def initialize sensor = Sensor.new
    @sensor = sensor
    @alarm_on = false
  end

  def check
    pressure = @sensor.pop_next_pressure_psi_value()

    @alarm_on = pressure < LOW_PRESSURE || HIGH_PRESSURE < pressure
  end
end
