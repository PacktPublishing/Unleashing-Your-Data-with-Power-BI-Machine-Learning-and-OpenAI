/*An M query for Engine Position in the Raw Data group of the Reference Data dataflow. Make sure you modify the url string component for "YOUR_ONEDRIVE_URL" */
let
  Source = Excel.Workbook(Web.Contents("https://microsoft-my.sharepoint.com/personal/grbeaumo_microsoft_com/Documents/AIML/read_me.xlsx"), null, true),
  #"Navigation 1" = Source{[Item = "Engine Position", Kind = "Sheet"]}[Data],
  #"Promoted headers" = Table.PromoteHeaders(#"Navigation 1", [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"Engine Code", type text}, {"Location of Engine", type text}})
in
  #"Changed column type"
