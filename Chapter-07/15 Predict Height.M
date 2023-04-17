/* An M query for Dataflows that will create training and testing data for Power BI ML to predict the height of an incident. Place this script in the ML Queries dataflow and be sure to reference the Strike Reports Curated query from the Strike Reports dataflow as a query before deploying this script. */
let
    Source = #"Strike Reports Curated",
    #"Filtered Rows" = Table.SelectRows(Source, each [Incident Date] >= #date(2010, 1, 1)),
    #"Filtered rows 1" = Table.SelectRows(#"Filtered Rows", each ([Airport ID] = "KATL" or [Airport ID] = "KAUS" or [Airport ID] = "KBNA" or [Airport ID] = "KCLT" or [Airport ID] = "KDEN" or [Airport ID] = "KDFW" or [Airport ID] = "KIAH" or [Airport ID] = "KJFK" or [Airport ID] = "KLGA" or [Airport ID] = "KMCO" or [Airport ID] = "KMEM" or [Airport ID] = "KORD" or [Airport ID] = "KPHL" or [Airport ID] = "KSDF" or [Airport ID] = "KSMF")),
    #"Filtered Rows1" = Table.SelectRows(#"Filtered rows 1", each ([Aircraft Class Code] = "A  ") and ([Height] <> null)),
    #"Added custom" = Table.TransformColumnTypes(Table.AddColumn(#"Filtered Rows1", "Month", each Date.Month([Incident Date])), {{"Month", Int64.Type}}),
    #"Removed columns" = Table.RemoveColumns(#"Added custom", {"Incident Date"})
in
    #"Removed columns"
