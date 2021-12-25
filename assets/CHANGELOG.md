# CHANGES
### Labels - Bug fix - TODO - New Feature - Not Implemented - TODO C (TODO Carryover)
#### 0.0.6 More Functions!
- **TODO C** Add more information for dates and times, and other feature-types.
- **TODO** Add string parser to parse data-types that are strings. **DONE**
- **TODO C** Add majority class for classes.
-  ^^^^^^^^^^^^ Might cost more performance than its worth, although maxkey is quite rapid.
- **TODO C** Add image URI to feature-types.
- **TODO C** Add ! for mutating methods **DONE**
- Added immutableoddframe with tuples and an immutable type.
- Added length(), size(), and width() bindings
- Added _dtype function
- Added Dict dispatch to OddFrame
- Moved indexing and iter into indexiter.jl
- **TODO** Separate data-types and labeled attributes **DONE**
- Added merge!() function **TODO** complete.
- Changed member functions to modulally global, for dox.
- Added supporting functions file, and member_func.jl
- Moved methods.jl, index_iter.jl to src/interface/
- Still working on merge function (actually annoying)
- **Bug fix** Fixed the issue where Oddframes.head() was getting called improperly without a count provided.
- **TODO** Add _head(::UnitRange), so you can view less columns at a time.
#### 0.0.5 FIXES AND ADDITIONS
- **Bug fix** Fixed problem with boolean indexing!
- **Bug fix** Fixed the issue with bad feature-type labeling.
- Extended the abilities of the feature-type determiner.
- **TODO** Add more information for dates and times.
- **TODO** Add majority class for classes.
- **TODO** Add image URI to feature-types.
- **TODO** Add ! for mutating methods
- **TODO** Add immutableoddframe with tuples and an immutable type.
- **New Feature** added dropna()
- Added iterators for calling columns or labels, etc.
- Updated logo
#### 0.0.4 REWORK
- Reworked the handling of indexes.
- Added shape() method
- Added read_csv() method
- Added new table styling with information tool-tips.
- **TODO** Need to fix boolean indexing!
- **TODO** Need to create methods.jl
- **TODO** Need to make column/row iterators
- **TODO** Need to add highest set-count
- **TODO** Need to fix figuring out type function (a little more accurate.)
- 
- Added Name and length check throws
- Added column descriptors
#### 0.0.3 __init__
- initalized this repository with all of the files in it.
