/* An M query for Dataflows that will create training and testing data for Power BI ML to predict the size of wildlife that struck an aircraft for an incident. Place this script in the ML Queries dataflow and be sure to reference the Strike Reports Curated query from the Strike Reports dataflow as a query before deploying this script. */

let
    Source = #"Strike Reports Curated",
    #"Filtered Rows" = Table.SelectRows(Source, each ([Airport ID] = "KCLT" or [Airport ID] = "KDEN" or [Airport ID] = "KDFW" or [Airport ID] = "KLGA" or [Airport ID] = "KMCO" or [Airport ID] = "KMEM" or [Airport ID] = "KORD" or [Airport ID] = "KPHL" or [Airport ID] = "KSDF" or [Airport ID] = "KSMF") and [Aircraft Class Code] = "A  "),
    #"Filtered Rows1" = Table.SelectRows(#"Filtered Rows", each [Incident Date] >= #date(2010, 1, 1)),
    #"Removed Other Columns" = Table.SelectColumns(#"Filtered Rows1", {"Incident Date", "Airport ID", "Aircraft Mass Code", "Number of Engines", "Phase of Flight", "Height", "Speed", "Sky", "Precipitation", "Ingested Other", "Indicated Damage", "Struck Random", "Damaged Random", "Struck Windshield", "Damaged Windshield", "Struck Nose", "Damaged Nose", "Struck Engine 1", "Damaged Engine 1", "Ingested Engine 1", "Struck Engine 2", "Damaged Engine 2", "Ingested Engine 2", "Struck Engine 3", "Damaged Engine 3", "Ingested Engine 3", "Struck Engine 4", "Damaged Engine 4", "Ingested Engine 4", "Struck Propeller", "Damaged Propeller", "Struck Wing or Rotor", "Damaged Wing or Rotor", "Struck Fuselage", "Damaged Fuselage", "Struck Landing Gear", "Damaged Landing Gear", "Struck Tail", "Damaged Tail", "Struck Lights", "Damaged Lights", "Struck Other", "Damaged Other", "Effect on Flight", "Size", "Number of Engines Struck", "Percentage of Engines Struck", "Number of Engines Ingested", "Percentage of Engines Ingested", "Number of Engines Damaged", "Perentage of Engines Damaged"}),
    #"Filtered Rows2" = Table.SelectRows(#"Removed Other Columns", each ([Size] <> null and [Size] <> "")),
    #"Added Custom" = Table.AddColumn(#"Filtered Rows2", "Month Number", each Date.Month([Incident Date])),
    #"Removed Columns" = Table.RemoveColumns(#"Added Custom", {"Incident Date"}),
    #"Transform columns" = Table.TransformColumnTypes(#"Removed Columns", {{"Month Number", type text}}),
    #"Replace errors" = Table.ReplaceErrorValues(#"Transform columns", {{"Month Number", null}})
in
    #"Replace errors"
