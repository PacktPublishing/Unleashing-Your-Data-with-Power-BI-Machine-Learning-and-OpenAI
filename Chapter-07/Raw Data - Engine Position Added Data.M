/*An M query for Engine Position Added Data in the Raw Data group of the Reference Data dataflow.*/
let
  Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WSspJzMtW0oHSsTrRSn6hPj5AATAVGwsA", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [#"Engine Code" = _t, #"Location of Engine" = _t])
in
  Source
