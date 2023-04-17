/* An M query for Dataflows that will create training and testing data for Power BI ML to predict if damage happened due to an incident. Place this script in the ML Queries dataflow and be sure to reference the Strike Reports Curated query from the Strike Reports dataflow as a query before deploying this script. */
let
    Source = #"Strike Reports Curated",
    #"Filtered rows 1" = Table.SelectRows(Source, each [Incident Date] >= #date(2014, 1, 1)),
    #"Filtered rows 2" = Table.SelectRows(#"Filtered rows 1", each ([Aircraft Class Code] = "A  ")),
    #"Choose columns" = Table.SelectColumns(#"Filtered rows 2", {"Incident Date", "Aircraft Mass Code", "Number of Engines", "Phase of Flight", "Height", "Speed", "Sky", "Precipitation", "Ingested Other", "Indicated Damage", "Struck Random", "Struck Windshield", "Struck Nose", "Struck Engine 1", "Ingested Engine 1", "Struck Engine 2", "Ingested Engine 2", "Struck Engine 3", "Ingested Engine 3", "Struck Engine 4", "Ingested Engine 4", "Struck Propeller", "Struck Wing or Rotor", "Struck Fuselage", "Struck Landing Gear", "Struck Tail", "Struck Lights", "Struck Other", "Effect on Flight", "Number Struck", "Size", "Number of Engines Struck", "Percentage of Engines Struck", "Number of Engines Ingested", "Percentage of Engines Ingested"}),
    #"Added custom" = Table.AddColumn(#"Choose columns", "Month Number", each Date.Month([Incident Date])),
    #"Changed column type" = Table.TransformColumnTypes(#"Added custom", {{"Month Number", Int64.Type}}),
    #"Removed columns" = Table.RemoveColumns(#"Changed column type", {"Incident Date"}),
    #"Replaced value" = Table.ReplaceValue(#"Removed columns", "", "empty", Replacer.ReplaceValue, {"Aircraft Mass Code"}),
    #"Replaced value 1" = Table.ReplaceValue(#"Replaced value", "", "empty", Replacer.ReplaceValue, {"Number of Engines"}),
    #"Replaced value 2" = Table.ReplaceValue(#"Replaced value 1", "", "empty", Replacer.ReplaceValue, {"Phase of Flight"}),
    #"Replaced value 3" = Table.ReplaceValue(#"Replaced value 2", "", "empty", Replacer.ReplaceValue, {"Sky"}),
    #"Replaced value 4" = Table.ReplaceValue(#"Replaced value 3", "", "empty", Replacer.ReplaceValue, {"Precipitation"}),
    #"Replaced value 5" = Table.ReplaceValue(#"Replaced value 4", "", "empty", Replacer.ReplaceValue, {"Effect on Flight"}),
    #"Replaced value 6" = Table.ReplaceValue(#"Replaced value 5", "", "empty", Replacer.ReplaceValue, {"Number Struck"}),
    #"Replaced value 7" = Table.ReplaceValue(#"Replaced value 6", "", "empty", Replacer.ReplaceValue, {"Size"}),
    #"Filtered rows" = Table.SelectRows(#"Replaced value 7", each ([Height] <> null) and ([Speed] <> null))
in
    #"Filtered rows"
