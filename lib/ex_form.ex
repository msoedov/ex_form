defmodule ExForm do

    def new do
        []
    end

    defp build(state, kind, question, extras, opts) do
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
        build(state, "multiple_choice", question = question, extras = extras, opts = opts)
    end

    def short_text(state, question, required \\ false, description \\ "", max_characters \\ nil) do
        kind = "short_text"
        body = %{
          "type": kind,
          "question": question,
          "description": description,
          "required": required,
          "max_characters": max_characters
        }
        state ++ [body]
    end

    def long_text(state, question, required \\ false, description \\ "", max_characters \\ nil) do
        kind = "short_text"
        body = %{
          "type": kind,
          "question": question,
          "description": description,
          "required": required,
          "max_characters": max_characters
        }
        state ++ [body]
    end

    def yes_no(state, question, required \\ false, description \\ "") do
        kind = "yes_no"
        body = %{
          "type": kind,
          "question": question,
          "description": description,
          "required": required,
        }
        state ++ [body]
    end

    def number(state, question, required \\ false, description \\ "", min_value \\ nil,  max_value \\ nil) do
        kind = "number"
        body = %{
          "type": kind,
          "question": question,
          "description": description,
          "min_value": min_value,
          "max_value": max_value,
          "required": required,
        }
        state ++ [body]
    end

    def rating(state, question, required \\ false, description \\ "", steps \\ 5,  shape \\ "star") do
        kind = "number"
        body = %{
          "type": kind,
          "question": question,
          "description": description,
          "steps": steps,
          "shape": shape,
          "required": required,
        }
        state ++ [body]
    end

    def opinion_scale(state, question, left, center, right, required \\ false, description \\ "", steps \\ 11, start_at_one \\ false) do
        kind = "number"
        body = %{
          "type": kind,
          "question": question,
          "description": description,
          "required": required,
          "label": %{
              "left": left,
              "center": center,
              "right": right
          },
          "steps": steps,
          "start_at_one": start_at_one

        }
        state ++ [body]
    end

    def publish(fields, title, web_hook, tags \\ [:deafult]) do
        data = %{
            "title": title,
            "tags": tags,
            "webhook_submit_url": web_hook,
            "fields": fields
        } |> Poison.encode!
        secret = System.get_env("TYPE_SECRET")
        response = Tesla.post("https://api.typeform.io/v0.4/forms", data, headers: %{"Content-Type" => "application/json", "X-API-TOKEN" => secret})
        response
    end
end
