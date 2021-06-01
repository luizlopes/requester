defmodule Requester do
  @moduledoc """
  Documentation for `Requester`.
  """

  def request(endpoint, count: count) do
    IO.puts("endpoint #{endpoint} #{count}")

    started_at = Time.utc_now()

    1..count
    |> Enum.map(fn _ -> create_request_task(endpoint) end)
    |> Enum.map(&handle_task/1)

    finished_at = Time.utc_now()

    total_seconds(started_at, finished_at)
  end

  defp create_request_task(endpoint) do
    Task.async(fn -> execute_request(endpoint) end)
  end

  defp execute_request(endpoint) do
    HTTPoison.get(endpoint, [], timeout: 3000, recv_timeout: 3000)
  end

  defp handle_task(task) do
    try do
      Task.await(task, 5000)
    catch
      :exit, _ -> IO.puts("aiai")
    end
  end

  defp total_seconds(started_at, finished_at) do
    {started_at_secs, _} = Time.to_seconds_after_midnight(started_at)
    {finished_at_secs, _} = Time.to_seconds_after_midnight(finished_at)

    finished_at_secs - started_at_secs
  end
end
