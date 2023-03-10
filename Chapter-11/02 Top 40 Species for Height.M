/*An M query to gnerate a list of the top 40 animals to be used in the Height predcition ML algorithm. It should be deployed in the ML Queries dataflow.*/
let
    Source = #"Strike Reports Curated",
    #"Filtered Rows" = Table.SelectRows(Source, each [Incident Date] >= #date(2010, 1, 1)),
    #"Filtered rows 1" = Table.SelectRows(#"Filtered Rows", each ([Airport ID] = "KATL" or [Airport ID] = "KAUS" or [Airport ID] = "KBNA" or [Airport ID] = "KCLT" or [Airport ID] = "KDEN" or [Airport ID] = "KDFW" or [Airport ID] = "KIAH" or [Airport ID] = "KJFK" or [Airport ID] = "KLGA" or [Airport ID] = "KMCO" or [Airport ID] = "KMEM" or [Airport ID] = "KORD" or [Airport ID] = "KPHL" or [Airport ID] = "KSDF" or [Airport ID] = "KSMF") and ([Aircraft Mass Code] = "3" or [Aircraft Mass Code] = "4" or [Aircraft Mass Code] = "5") and ([Number of Engines] = "2")),
    #"Filtered Rows1" = Table.SelectRows(#"Filtered rows 1", each ([Aircraft Class Code] = "A  ") and ([Height] <> null and [Height] <> 0)),
    #"Removed Other Columns" = Table.SelectColumns(#"Filtered Rows1", {"Incident Date", "Time of Day", "Airport ID", "Aircraft Mass Code", "Number of Engines", "Phase of Flight", "Height", "Speed", "Distance", "Sky", "Precipitation", "Cost of Repairs Adjusted", "Other Costs Adjusted", "Ingested Other", "Indicated Damage", "Damage Level", "Struck Random", "Damaged Random", "Struck Windshield", "Damaged Windshield", "Struck Nose", "Damaged Nose", "Struck Engine 1", "Damaged Engine 1", "Ingested Engine 1", "Struck Engine 2", "Damaged Engine 2", "Ingested Engine 2", "Struck Engine 3", "Damaged Engine 3", "Ingested Engine 3", "Struck Engine 4", "Damaged Engine 4", "Ingested Engine 4", "Struck Propeller", "Damaged Propeller", "Struck Wing or Rotor", "Damaged Wing or Rotor", "Struck Fuselage", "Damaged Fuselage", "Struck Landing Gear", "Damaged Landing Gear", "Struck Tail", "Damaged Tail", "Struck Lights", "Damaged Lights", "Struck Other", "Damaged Other", "Effect on Flight", "Species ID", "Species", "Warned", "Number Seen", "Number Struck", "Size", "Total Costs Adjusted", "Number of Engines Struck", "Percentage of Engines Struck", "Number of Engines Ingested", "Percentage of Engines Ingested", "Number of Engines Damaged", "Perentage of Engines Damaged", "Engine Codes Info Key"}),
    #"Replaced Value" = Table.ReplaceValue(#"Removed Other Columns",null,"empty",Replacer.ReplaceValue,{"Size"}),
    #"Replaced Value1" = Table.ReplaceValue(#"Replaced Value",null,0,Replacer.ReplaceValue,{"Total Costs Adjusted"}),
    #"Added custom" = Table.TransformColumnTypes(Table.AddColumn(#"Replaced Value1", "Month", each Date.Month([Incident Date])), {{"Month", Int64.Type}}),
    #"Removed columns" = Table.RemoveColumns(#"Added custom", {"Incident Date"}),
    #"Grouped rows" = Table.Group(#"Removed columns", {"Species ID", "Species"}, {{"Count", each Table.RowCount(_), Int64.Type}}),
    #"Sorted rows" = Table.Sort(#"Grouped rows", {{"Count", Order.Descending}}),
    #"Filtered rows 2" = Table.SelectRows(#"Sorted rows", each ([Species] <> "Unknown bird" and [Species] <> "Unknown bird - large" and [Species] <> "Unknown bird - medium" and [Species] <> "Unknown bird - small" and [Species] <> "Unknown bird or bat")),
    #"Kept top rows" = Table.FirstN(#"Filtered rows 2", 40)
in
    #"Kept top rows"
