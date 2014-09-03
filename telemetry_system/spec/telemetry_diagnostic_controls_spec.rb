require "telemetry_diagnostic_controls"

describe TelemetryDiagnosticControls do
  it "does something" do
    ctrl = TelemetryDiagnosticControls.new
    ctrl.check_transmission
    ctrl.diagnostic_info
  end
end
