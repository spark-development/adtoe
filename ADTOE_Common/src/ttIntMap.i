/**
 * ttIntMap.i
 *
 * Holds a "map" of Integer values (key: integer, value: integer).
 */

define temp-table ttIntMap no-undo
  field iKey as integer
  field iValue as integer
  index PKKey is primary unique iKey.