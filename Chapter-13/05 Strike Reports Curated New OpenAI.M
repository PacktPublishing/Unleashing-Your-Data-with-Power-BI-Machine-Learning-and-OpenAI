/* The script below is for the final Chapter 13 query that integrates two OpenAI use cases and one Cognitive Services use case. */
let
  Source = #"Strike Reports Curated New",
  #"Filtered rows" = Table.SelectRows(Source, each [Operator] <> "BUSINESS" and [Operator] <> "PRIVATELY OWNED" and [Operator] <> "UNKNOWN" and [Operator] <> "UNKNOWN COMMERCIAL" and [Aircraft] <> "UNKNOWN" and [Remarks] <> "" and [Species] <> "Unknown bird" and [Species] <> "Unknown bird - large" and [Species] <> "Unknown bird - medium" and [Species] <> "Unknown bird - small" and [Species] <> "Unknown bird or bat"),
  #"Filtered rows 1" = Table.SelectRows(#"Filtered rows", each [Incident Date] >= #date(2022, 12, 1)),
  #"Added custom" = Table.AddColumn(#"Filtered rows 1", "Text Generation Prompt", each "Tell me about the airplane model " & [Aircraft] & " operated by " & [Operator] & " in three sentences:"),
  #"Changed column type" = Table.TransformColumnTypes(#"Added custom", {{"Text Generation Prompt", type text}}),
  #"Added custom 1" = Table.AddColumn(#"Changed column type", "Text Summarization Prompt", each "Summarize the following: A " & [Operator] & " " & [Aircraft] & " struck a " & [Species] & ". Remarks on the FAA report were: " & [Remarks]),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Added custom 1", {{"Text Summarization Prompt", type text}}),
  #"Added custom 2" = Table.AddColumn(#"Changed column type 1", "OpenAI Aircraft Description", each OpenAIshort([Text Generation Prompt])),
  #"Added custom 3" = Table.AddColumn(#"Added custom 2", "OpenAI Remarks Summarization", each OpenAIlong([Text Summarization Prompt])),
  #"Transform columns" = Table.TransformColumnTypes(#"Added custom 3", {{"OpenAI Aircraft Description", type text}, {"OpenAI Remarks Summarization", type text}}),
  #"Replace errors" = Table.ReplaceErrorValues(#"Transform columns", {{"OpenAI Aircraft Description", null}, {"OpenAI Remarks Summarization", null}}),
  #"Invoked CognitiveServices.ScoreSentiment" = Table.AddColumn(#"Replace errors", "CognitiveServices.ScoreSentiment", each CognitiveServices.ScoreSentiment([Remarks], "")),
  #"Post process CognitiveServices.ScoreSentiment" = AIFunctions.PostProcess(#"Invoked CognitiveServices.ScoreSentiment", "CognitiveServices.ScoreSentiment", Record.FieldOrDefault(Value.Metadata(CognitiveServices.ScoreSentiment), "PostProcessFunctionName", "CognitiveServices.ScoreSentimenttexttext")),
  #"Changed column type 2" = Table.TransformColumnTypes(#"Post process CognitiveServices.ScoreSentiment", {{"CognitiveServices.ScoreSentiment", type number}})
in
  #"Changed column type 2"
