/*An M query for Aircraft Type Added Data in the Raw Data group of the Reference Data dataflow.*/
let
  Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WSspJzMtW0oHSsTrRSn6hPj5AATAVGwsA", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [#"Aircraft Code" = _t, #"Aircraft Classification" = _t])
in
  Source
