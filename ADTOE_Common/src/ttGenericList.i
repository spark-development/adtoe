/**
 * ttGenericList.i
 *
 * Holds a "list" of Generic values.
 */

&if defined(TT_GENERIC_LIST) = 0 &then
&global-define TT_GENERIC_LIST 1
{ttGenericMap.i &key-datatype="integer" &value-datatype={&value-datatype}} 
define temp-table ttGenericList no-undo
  like ttGenericMap
  index UQValue is unique gValue.
  
&endif