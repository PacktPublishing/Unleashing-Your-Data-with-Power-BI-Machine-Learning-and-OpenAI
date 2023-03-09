let
  Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45W8sxLzs8tyEktSVXIL1LwzSwuzsxLV9KhknhsLAA=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [#"Manufacturer Code" = _t, #"Model Code" = _t, #"Engine Manufacturer" = _t, #"Engine Model" = _t])
in
  Source
