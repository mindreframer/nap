defmodule Nap.Config do
  def nap_update do
    System.get_env("nap_update") || System.get_env("nap_u")
  end

  def nap_interactive do
    System.get_env("nap_interactive") || System.get_env("nap_i")
  end

  def nap_verbose do
    System.get_env("nap_verbose") || System.get_env("nap_v")
  end
end
