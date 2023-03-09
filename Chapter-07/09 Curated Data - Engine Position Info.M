/*An M query for Engine Position Info in the Curated Data group of the Reference Data dataflow.*/
let
  Source = #"Engine Position",
  #"Filtered rows" = Table.SelectRows(Source, each ([Engine Code] <> null)),
  #"Appended query" = Table.Combine({#"Filtered rows", #"Engine Position Added Data"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Appended query", {{"Engine Code", type text}, {"Location of Engine", type text}})
in
  #"Changed column type"
