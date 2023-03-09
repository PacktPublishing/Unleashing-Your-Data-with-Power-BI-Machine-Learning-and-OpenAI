/*An M query for Aircraft Type in the Curated Data group of the Reference Data dataflow.*/
let
  Source = #"Aircraft Type",
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"Aircraft Code", type text}, {"Aircraft Classification", type text}}),
  #"Filtered rows" = Table.SelectRows(#"Changed column type", each ([Aircraft Code] <> null)),
  #"Appended query" = Table.Combine({#"Filtered rows", #"Aircraft Type Added Data"})
in
  #"Appended query"
