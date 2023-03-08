/*An M query for Aircraft Type in the Raw Data group of the Reference Data dataflow. Make sure you modify the url string component for "YOUR_ONEDRIVE_URL" */
let
  Source = Excel.Workbook(Web.Contents("https://YOUR_ONEDRIVE_URL/read_me.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Aircraft Type", Kind = "Sheet"]}[Data],
  #"Changed column type" = Table.TransformColumnTypes(#"Navigation 1", {{"Column1", type text}, {"Column2", type text}})
in
  #"Changed column type"
