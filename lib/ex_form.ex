defmodule ExForm do

    def new do
        []
    end

    def multiple_choice(state, question, choices, required \\ false, description \\ "") do
        kind = "multiple_choice"
        body = %{
            "type": kind,
            "question": question,
            "description": description,
            "required": required,
            "choices": Enum.map(choices, fn c -> %{ "label" => c } end)
        }
        state ++ [body]
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
