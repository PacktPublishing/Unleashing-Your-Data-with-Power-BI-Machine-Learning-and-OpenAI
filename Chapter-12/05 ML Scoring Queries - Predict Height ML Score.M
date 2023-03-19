/* This query will reference the Strike Reports Curated New query in the Sources group of the ML Queries dataflow. It should be named Predict Height ML Score. */

let
  Source = #"Strike Reports Curated New",
  #"Filtered Rows" = Table.SelectRows(Source, each ([Airport ID] = "KATL" or [Airport ID] = "KAUS" or [Airport ID] = "KBNA" or [Airport ID] = "KCLT" or [Airport ID] = "KDEN" or [Airport ID] = "KDFW" or [Airport ID] = "KIAH" or [Airport ID] = "KJFK" or [Airport ID] = "KLGA" or [Airport ID] = "KMCO" or [Airport ID] = "KMEM" or [Airport ID] = "KORD" or [Airport ID] = "KPHL" or [Airport ID] = "KSDF" or [Airport ID] = "KSMF") and [Aircraft Class Code] = "A  "),
  #"Removed Other Columns" = Table.SelectColumns(#"Filtered Rows", {"Incident Date", "Time of Day", "Airport ID", "Aircraft Mass Code", "Number of Engines", "Phase of Flight", "Height", "Speed", "Sky", "Precipitation", "Cost of Repairs Adjusted", "Other Costs Adjusted", "Ingested Other", "Indicated Damage", "Damage Level", "Struck Random", "Damaged Random", "Struck Windshield", "Damaged Windshield", "Struck Nose", "Damaged Nose", "Struck Engine 1", "Damaged Engine 1", "Ingested Engine 1", "Struck Engine 2", "Damaged Engine 2", "Ingested Engine 2", "Struck Engine 3", "Damaged Engine 3", "Ingested Engine 3", "Struck Engine 4", "Damaged Engine 4", "Ingested Engine 4", "Struck Propeller", "Damaged Propeller", "Struck Wing or Rotor", "Damaged Wing or Rotor", "Struck Fuselage", "Damaged Fuselage", "Struck Landing Gear", "Damaged Landing Gear", "Struck Tail", "Damaged Tail", "Struck Lights", "Damaged Lights", "Struck Other", "Damaged Other", "Effect on Flight", "Warned", "Number Seen", "Number Struck", "Size", "Total Costs Adjusted", "Number of Engines Struck", "Percentage of Engines Struck", "Number of Engines Ingested", "Percentage of Engines Ingested", "Number of Engines Damaged", "Perentage of Engines Damaged", "Engine Codes Info Key"}),
  #"Filtered Rows2" = Table.SelectRows(#"Removed Other Columns", each ([Size] <> null and [Size] <> "") and ([Height] <> null and [Height] <> 0) and ([Speed] <> null and [Speed] <> 0)),
  #"Added Custom" = Table.AddColumn(#"Filtered Rows2", "Month Number", each Date.Month([Incident Date])),
  #"Removed Columns" = Table.RemoveColumns(#"Added Custom", {"Incident Date"}),
  #"Transform columns" = Table.TransformColumnTypes(#"Removed Columns", {{"Month Number", type text}}),
  #"Replace errors" = Table.ReplaceErrorValues(#"Transform columns", {{"Month Number", null}})
in
  #"Replace errors"
