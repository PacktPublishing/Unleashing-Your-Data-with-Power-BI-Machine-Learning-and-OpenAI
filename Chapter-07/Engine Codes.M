/*An M query for Engine Codes in the Raw Data group of the Reference Data dataflow. Make sure you modify the url string component for "YOUR_ONEDRIVE_URL" */
let
  Source = Excel.Workbook(Web.Contents("https://YOUR_ONEDRIVE_URL/read_me.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Engine Codes", Kind = "Sheet"]}[Data],
  #"Changed column type 1" = Table.TransformColumnTypes(#"Navigation 1", {{"Column1", type text}, {"Column2", type text}, {"Column3", type text}, {"Column4", type text}, {"Column5", type text}, {"Column6", type text}}),
  #"Removed top rows" = Table.Skip(#"Changed column type 1", 2),
  #"Promoted headers" = Table.PromoteHeaders(#"Removed top rows", [PromoteAllScalars = true]),
  #"Removed top rows 1" = Table.Skip(#"Promoted headers", 1),
  #"Removed columns" = Table.RemoveColumns(#"Removed top rows 1", {"Column5", "Column6"}),
  #"Transform columns" = Table.TransformColumnTypes(#"Removed columns", {{"Manufacturer Code", type text}, {"Engine Model", type text}}),
  #"Filled down" = Table.FillDown(#"Transform columns", {"Manufacturer Code"}),
  #"Filled down 1" = Table.FillDown(#"Filled down", {"Engine Manufacturer"})
in
  #"Filled down 1"
