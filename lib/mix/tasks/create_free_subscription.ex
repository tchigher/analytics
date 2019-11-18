defmodule Mix.Tasks.CreateFreeSubscription do
  use Mix.Task
  use Plausible.Repo
  require Logger
  alias Plausible.Billing.Subscription

  @doc """
  This is scheduled to run every 6 hours.
  """

  def run([user_id]) do
    Application.ensure_all_started(:plausible)
    execute(user_id)
  end

  def run(_), do: IO.puts("Usage - mix create_free_subscription <user_id>")

  def execute(user_id) do
    Subscription.free(%{user_id: user_id})
    |> Repo.insert!
  end
end