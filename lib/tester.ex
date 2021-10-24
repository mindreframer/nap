defmodule Tester do
  # require Pathex

  # import Pathex, only: [path: 1, path: 2, "~>": 2]

  use Pathex

  def check do

    path_to_strees = path :user / :private / :addresses / 0 / :street
    v = %{
      user: %{
        id: 1,
        name: "hissssst",
        private: %{
          phone: "123-456-789",
          addresses: [
             [city: "City", street: "6th avenue", mail_index: 123456]
          ]
        }
      }
    }

    Pathex.view(v, path_to_strees)

    tuples = %{
      a: {:a, 2, 3}
    }

    tuples_path = path :a / 1

    Pathex.view(tuples, tuples_path)
  end
end
