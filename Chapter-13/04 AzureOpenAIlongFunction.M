/* Remember the replace PBI_OpenAI_project with your Azure OpenAI resource name, davinci_PBIML with your deployent name, and abc123xyz with your Azure OpenAPI key. */
let
    callAzureOpenAI = (prompt as text) as text =>
        let
            jsonPayload = "{""prompt"": """ & prompt & """, ""max_tokens"": " & Text.From(500) & "}",
            url = "https://" & "PBI_OpenAI_project" & ".openai.azure.com" & "/openai/deployments/" & "davinci-PBIML" & "/completions?api-version=2022-12-01",
            headers = [#"Content-Type"="application/json", #"api-key"="abc123xyz"],
            response = Web.Contents(url, [Headers=headers, Content=Text.ToBinary(jsonPayload)]),
            jsonResponse = Json.Document(response),
            choices = jsonResponse[choices],
            text = choices{0}[text]
        in
            text
in
    callAzureOpenAI
