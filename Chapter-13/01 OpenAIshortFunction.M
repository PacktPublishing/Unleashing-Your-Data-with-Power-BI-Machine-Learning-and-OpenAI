/* Replace abc123xyz with your OpenAI API key! */
let
    callOpenAI = (prompt as text) as text =>
        let
            jsonPayload = "{""prompt"": """ & prompt & """, ""max_tokens"": " & Text.From(120) & "}",
            url = "https://api.openai.com/v1/engines/text-davinci-003/completions",
            headers = [#"Content-Type"="application/json", #"Authorization"="Bearer abc123xyz"],
            response = Web.Contents(url, [Headers=headers, Content=Text.ToBinary(jsonPayload)]),
            jsonResponse = Json.Document(response),
            choices = jsonResponse[choices],
            text = choices{0}[text]
        in
            text
in
    callOpenAI
