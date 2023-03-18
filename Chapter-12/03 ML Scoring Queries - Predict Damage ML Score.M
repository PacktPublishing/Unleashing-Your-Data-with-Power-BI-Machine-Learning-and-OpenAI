/* This query will reference the Strike Reports Curated New query in the Sources group of the ML Queries dataflow. It should be named Predict Damage ML Score. */
let
    Source = #"Strike Reports Curated New",
  #"Filtered rows 2" = Table.SelectRows(Source, each [Aircraft Class Code] = "A  " and ([Airport ID] = "KATL" or [Airport ID] = "KAUS" or [Airport ID] = "KBNA" or [Airport ID] = "KCLT" or [Airport ID] = "KDEN" or [Airport ID] = "KDFW" or [Airport ID] = "KIAH" or [Airport ID] = "KJFK" or [Airport ID] = "KLGA" or [Airport ID] = "KMCO" or [Airport ID] = "KMEM" or [Airport ID] = "KORD" or [Airport ID] = "KPHL" or [Airport ID] = "KSDF" or [Airport ID] = "KSMF")),
  #"Choose columns" = Table.SelectColumns(#"Filtered rows 2", {"Incident Date", "Time of Day", "Airport ID", "Aircraft Mass Code", "Number of Engines", "Phase of Flight", "Height", "Speed", "Distance", "Sky", "Precipitation", "Ingested Other", "Indicated Damage", "Struck Random", "Struck Windshield", "Struck Nose", "Struck Engine 1", "Ingested Engine 1", "Struck Engine 2", "Ingested Engine 2", "Struck Engine 3", "Ingested Engine 3", "Struck Engine 4", "Ingested Engine 4", "Struck Propeller", "Struck Wing or Rotor", "Struck Fuselage", "Struck Landing Gear", "Struck Tail", "Struck Lights", "Struck Other", "Effect on Flight", "Species ID", "Species", "Warned", "Number Seen", "Number Struck", "Size", "Number of Engines Struck", "Percentage of Engines Struck", "Number of Engines Ingested", "Percentage of Engines Ingested", "Engine Codes Info Key"}),
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
  #"Filtered rows" = Table.SelectRows(#"Replaced value 7", each ([Height] <> null and [Height] <> 0) and ([Speed] <> null and [Speed] <> 0) and ([Distance] <> null))
in
    #"Filtered rows"
