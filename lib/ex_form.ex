defmodule ExForm do

    def new do
        []
    end

    def publish(fields, web_hook=nil, tags=nil) do
        data = %{
            "title": "My new Typeform",
            "tags": ["first-forms"],
            "webhook_submit_url": "http://requestb.in/116zx9u1",
            "fields": fields
        } |> Poison.encode!
        response = Tesla.post("http://httpbin.org/post", data, headers: %{"Content-Type" => "application/json"})
        response
    end
end
