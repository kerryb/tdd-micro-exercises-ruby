class TelemetryClient

  # The communication with the server is simulated in this implementation.
  #Because the focus of the exercise is on the other class.

  DIAGNOSTIC_MESSAGE = 'AT#UD'

  def initialize
    @online_status = false
    @diagnostic_message_just_sent = false
  end

  def online_status
    @online_status
  end

  def connect(telemetry_server_connection_string)
    if telemetry_server_connection_string.nil? || telemetry_server_connection_string == ''
      raise Exception, 'Argument Null'
    end

    # Fake the connection with 20% chances of success
    success = rand() <= 0.2

    @online_status = success
  end

  def disconnect 
    @online_status = false
  end

  def send(message)
    if message.nil? || message == ''
      raise Exception, 'Argument Null'
    end

    # The simulation of Send() actually just remember if the last message sent was a diagnostic message.
    #This information will be used to simulate the Receive(). Indeed there is no real server listening.
    @diagnostic_message_just_sent = message == DIAGNOSTIC_MESSAGE
end

  def receive
    message = ''

    if @diagnostic_message_just_sent
      message = "LAST TX rate................ 100 MBPS\r\n" \
              + "HIGHEST TX rate............. 100 MBPS\r\n" \
              + "LAST RX rate................ 100 MBPS\r\n" \
              + "HIGHEST RX rate............. 100 MBPS\r\n" \
              + "BIT RATE.................... 100000000\r\n" \
              + "WORD LEN.................... 16\r\n" \
              + "WORD/FRAME.................. 511\r\n" \
              + "BITS/FRAME.................. 8192\r\n" \
              + "MODULATION TYPE............. PCM/FM\r\n" \
              + "TX Digital Los.............. 0.75\r\n" \
              + "RX Digital Los.............. 0.10\r\n" \
              + "BEP Test.................... -5\r\n"  \
              + "Local Rtrn Count............ 00\r\n"  \
              + "Remote Rtrn Count........... 00"
    else
      # Simulate the reception of a response message returning a random message.

      rand(50..110).times do
        message += rand(40..126).chr()
      end
    end

    message
  end
end
