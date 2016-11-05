defmodule ExForm do
    @moduledoc """

    Api wrapper module for http://docs.typeform.io
    
    """
    def new do
        []
    end

    defp append(state, kind, question, extras, opts) do
        required = Keyword.get(opts, :required, false)
        description = Keyword.get(opts, :description, "")
        data = %{
            "type": kind,
            "question": question,
            "description": description,
            "required": required,
        }
        state ++ [Dict.merge(data, extras)]
    end

    def multiple_choice(state, question, choices, opts \\ []) do
        extras = %{"choices": Enum.map(choices, fn c -> %{"label" => c} end)}
        append(state, "multiple_choice", question = question, extras = extras, opts = opts)
    end

    def short_text(state, question, max_characters \\ nil, opts \\ []) do
        extras = case max_characters do
            nil -> %{}
            _ -> %{"max_characters": max_characters}
        end
        append(state, "short_text", question = question, extras = extras, opts = opts)
    end

    def long_text(state, question, max_characters \\ nil, opts \\ []) do
        extras = case max_characters do
            nil -> %{}
            _ -> %{"max_characters": max_characters}
        end
        append(state, "long_text", question = question, extras = extras, opts = opts)
    end

    def yes_no(state, question, opts \\ []) do
        append(state, "yes_no", question = question, extras = %{}, opts = opts)
    end

    def number(state, question, min_value \\ nil,  max_value \\ nil, opts \\ []) do
        extras = %{}
        extras = if min_value, do: Dict.put(extras, "min_value", min_value), else: extras
        extras = if max_value, do: Dict.put(extras, "max_value", max_value), else: extras
        append(state, "number", question = question, extras = extras, opts = opts)
    end

    def rating(state, question, steps \\ 5,  shape \\ "star", opts \\ []) do
        extras = %{
          "shape": shape,
          "steps": steps,
        }
        append(state, "rating", question = question, extras = extras, opts = opts)
    end

    def opinion_scale(state, question, left, center, right, steps \\ 11, start_at_one \\ false, opts \\ []) do
        extras = %{
          "labels": %{
              "left": left,
              "center": center,
              "right": right
          },
          "steps": steps,
          "start_at_one": start_at_one

        }
        append(state, "opinion_scale", question = question, extras = extras, opts = opts)
    end

    def build(fields, title, web_hook, tags \\ [:deafult]) do
        data = %{
            "title": title,
            "tags": tags,
            "webhook_submit_url": web_hook,
            "fields": fields
        }
    end

    def publish(fields, title, web_hook, tags \\ [:deafult]) do
        build(fields, title, web_hook, tags) |> typeform_publish()
    end

    def typeform_publish(data) do
        data = data |> Poison.encode!
        secret = System.get_env("TYPE_SECRET")
        headers = %{"Content-Type" => "application/json", "X-API-TOKEN" => secret}
        response = Tesla.post("https://api.typeform.io/v0.4/forms", data, headers: headers)
        case response.status do
            201 -> {:ok, Poison.decode!(response.body)}
            _ -> {:error, Poison.decode(response.body)}
        end
    end
end
