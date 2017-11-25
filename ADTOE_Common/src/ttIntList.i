/**
 * ttIntList.i
 *
 * Holds a "list" of Integer values.
 */

{ttIntMap.i} 
define temp-table ttIntList no-undo
  like ttIntMap
  index UQValue is unique iValue.