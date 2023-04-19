/* This query will reference the Strike Reports Curated New query in the Sources group of the ML Queries dataflow. It should be named Predict Size ML Score. */

let
    Source = #"Strike Reports Curated New",
    #"Filtered Rows" = Table.SelectRows(Source, each ([Airport ID] = "KATL" or [Airport ID] = "KAUS" or [Airport ID] = "KBNA" or [Airport ID] = "KCLT" or [Airport ID] = "KDEN" or [Airport ID] = "KDFW" or [Airport ID] = "KIAH" or [Airport ID] = "KJFK" or [Airport ID] = "KLGA" or [Airport ID] = "KMCO" or [Airport ID] = "KMEM" or [Airport ID] = "KORD" or [Airport ID] = "KPHL" or [Airport ID] = "KSDF" or [Airport ID] = "KSMF") and ([Aircraft Class Code] = "A  ")),
    #"Filtered Rows2" = Table.SelectRows(#"Filtered Rows", each ([Size] <> null and [Size] <> "")),
    #"Added Custom" = Table.AddColumn(#"Filtered Rows2", "Month Number", each Date.Month([Incident Date])),
    #"Removed Columns" = Table.RemoveColumns(#"Added Custom", {"Incident Date"}),
    #"Transform columns" = Table.TransformColumnTypes(#"Removed Columns", {{"Month Number", type text}}),
    #"Replace errors" = Table.ReplaceErrorValues(#"Transform columns", {{"Month Number", null}}),
    #"Filtered rows 1" = Table.SelectRows(#"Replace errors", each ([Height] <> null and [Height] <> 0) and ([Speed] <> null and [Speed] <> 0))
in
    #"Filtered rows 1"
