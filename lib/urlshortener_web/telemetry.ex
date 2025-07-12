defmodule UrlshortenerWeb.Telemetry do
  @moduledoc """
  Telemetry supervisor for handling metrics and monitoring.
  """
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      # Telemetry poller will report the given measurements
      # every 10 seconds. You can also use it to report any
      # custom metrics you might have.
      {TelemetryPoller, measurements: periodic_measurements(), period: 10_000}
      # Add reporters as children of your supervision tree.
      # {TelemetryMetricsPrometheus, []}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp periodic_measurements do
    [
      # A module, function and arguments to be invoked periodically.
      # {UrlshortenerWeb, :count_users, []}
    ]
  end
end