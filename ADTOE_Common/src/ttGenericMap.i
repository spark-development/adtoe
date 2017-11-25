/**
 * ttGenericMap.i
 *
 * Holds a "map" of Generic values.
 */

&if defined(TT_GENERIC_MAP) = 0 &then
&global-define TT_GENERIC_MAP 1
define temp-table ttGenericMap no-undo
  field gKey as {&key-datatype}
  field gValue as {&value-datatype}
  index PKKey is primary unique gKey.
  
&endif