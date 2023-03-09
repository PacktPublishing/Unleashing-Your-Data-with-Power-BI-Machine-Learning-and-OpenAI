let
  Source = Csv.Document(Web.Contents("G/STRIKE_REPORTS.txt"), [Delimiter = ",", Columns = 100, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true])
in
  #"Promoted headers"
