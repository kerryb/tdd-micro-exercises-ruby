require "telemetry_diagnostic_controls"

describe TelemetryDiagnosticControls do
  describe "#check_transmission" do
    subject { described_class.new telemetry_client: telemetry_client }
    let(:telemetry_client) { double :telemetry_client, online_status: true, disconnect: true, connect: true, send: true, receive: true }

    it "sends a diagnostic message" do
      subject.check_transmission
      expect(telemetry_client).to have_received(:send).with TelemetryClient::DIAGNOSTIC_MESSAGE
    end

    it "disconnects before connecting" do
      allow(telemetry_client).to receive(:online_status) { false }
      subject.check_transmission
      expect(telemetry_client).to have_received(:disconnect).ordered
      expect(telemetry_client).to have_received(:connect).ordered
    end
  end
end
