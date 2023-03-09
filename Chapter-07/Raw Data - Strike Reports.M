/*An M query for Strike Reports in the Raw Data group of the Strike Reports dataflow. Make sure you modify the url string component for "YOUR_ONEDRIVE_URL" */
let
  Source = Csv.Document(Web.Contents("https://YOUR_ONEDRIVE_URL/STRIKE_REPORTS.txt"), [Delimiter = ",", Columns = 100, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true])
in
  #"Promoted headers"
