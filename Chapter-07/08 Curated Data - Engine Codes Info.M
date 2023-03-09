/*An M query for Engine Codes Info in the Curated Data group of the Reference Data dataflow.*/
let
  Source = #"Engine Codes",
  #"Filtered rows" = Table.SelectRows(Source, each ([Model Code] <> null)),
  #"Appended query" = Table.Combine({#"Filtered rows", #"Engine Codes Added Data"}),
  #"Added index" = Table.AddIndexColumn(#"Appended query", "Index", 1, 1, Int64.Type),
  #"Renamed columns" = Table.RenameColumns(#"Added index", {{"Index", "Engine Codes Info Key"}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Renamed columns", {{"Engine Model", type text}})
in
  #"Changed column type 1"
