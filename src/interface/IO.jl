"""
## read(uri::String, T::Type) -> ::T
High-level binding call to read any data file into T. Other calls, and possible
data-files are
- read_csv (csv)
- read_json (json)
- read_xl (excel)
- read_tb (twobit)
- read_fa (fasta)
- read_rs (raw sequence)
"""
function read(uri::String, T::Type)

end
"""
## read_tb(uri::String, T::Type) -> ::T
Reades two-bit data.
"""
function read_csv(uri::String, T::Type)

end
"""
## read_tb(uri::String, T::Type) -> ::T
Reades two-bit data.
"""
function read_json(uri::String, T::Type)

end
"""
## read_tb(uri::String, T::Type) -> ::T
Reades two-bit data.
"""
function read_xl(uri::String, T::Type)

end
"""
## read_tb(uri::String, T::Type) -> ::T
Reades two-bit data.
"""
function read_tb(uri::String, T::Type)

end
"""
## read_fa(uri::String, T::Type) -> ::T
Reads Fasta data.
"""
function read_fa(uri::String, T::Type)

end
"""
## read_rs(uri::String, T::Type) -> ::T
Reads raw sequence data
"""
function read_rs(uri::String, T::Type)

end
