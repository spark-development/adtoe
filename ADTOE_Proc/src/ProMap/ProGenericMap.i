/**
 * ProMap/ProGenericMap.i
 *
 * OpenEdge implementation of an Abstract Data Type representing a map.
 */
{ttGenericMap.i {*}}

/* --- Main Block --- */
/* Nothing here to do */
/* --- End Main Block --- */

procedure keyList:
  /**
   * Returns the list with keys from the map.
   *
   * @return character pcKeyList
   */
  define output parameter pcKeyList as character no-undo.
  
  for each ttGenericMap no-lock:
    pcKeyList = substitute("&1,&2", pcKeyList, ttGenericMap.gKey).
  end.
  
  pcKeyList = trim(pcKeyList, ",").
end procedure.

procedure valueList:
  /**
   * Returns the list with values from the map.
   *
   * @return character pcValueList
   */
  define output parameter pcValueList as character no-undo.
  
  for each ttGenericMap no-lock:
    pcValueList = substitute("&1,&2", pcValueList, ttGenericMap.gValue).
  end.
  
  pcValueList = trim(pcValueList, ",").
end procedure.

procedure isEmpty:
  /**
   * Returns the size of the list.
   *
   * @return plIsEmpty integer
   */
  define output parameter plIsEmpty as logical no-undo.
  
  plIsEmpty = not temp-table ttGenericMap:has-records.
end procedure.

procedure emptyMap:
  /**
   * Empty the map.
   */
  empty temp-table ttGenericMap.
end procedure.

procedure putElement:
  /**
   * Pushes an element into the map.
   *
   * @param {&key-dataType} pgKey   The key to be pushed into the map.
   * @param {&value-dataType} pgValue The value to be pushed into the list.
   */
  define input  parameter pgKey   as {&key-dataType}    no-undo.
  define input  parameter pgValue as {&value-dataType}  no-undo.
  
  create ttGenericMap.
  assign
    ttGenericMap.gKey   = pgKey
    ttGenericMap.gValue = pgValue.
end procedure.

procedure getElement:
  /**
   * Gets an element from the map.
   *
   * @param {&key-dataType} pgKey   The key to be fetch into the map.
   
   * @return {&value-dataType} pgValue
   */
  define input  parameter pgKey   as {&key-dataType}    no-undo.
  define output parameter pgValue as {&value-dataType}  no-undo initial ?.
  
  find first ttGenericMap no-lock
    where ttGenericMap.gKey = pgKey no-error.
    
  if not available ttGenericMap then
    return.
  
  pgValue = ttGenericMap.gValue.
end procedure.

procedure removeElement:
  /**
   * Removes an element from the map.
   *
   * @param {&key-dataType} pgKey   The key to be removed into the map.
   */
  define input  parameter pgKey   as {&key-dataType}    no-undo.
  
  find first ttGenericMap exclusive-lock
    where ttGenericMap.gKey = pgKey no-error.
    
  if not available ttGenericMap then
    return.
    
  delete ttGenericMap.
end procedure.

procedure has:
  /**
   * Searches the map for the given key.
   *
   * @param {&key-dataType} pgKey   The key to be removed into the map.
   *
   * @return logical plHas
   */
  define input  parameter pgKey  as {&key-dataType} no-undo.
  define output parameter plHas  as logical         no-undo initial false.
  
  plHas = can-find (first ttGenericMap no-lock where ttGenericMap.gKey = pgKey).
end procedure.

procedure toString:
  /**
   * Returns the string representation of the map
   *
   * @return character pcMap
   */
  define output parameter pcMap as character no-undo.
  
  for each ttGenericMap no-lock:
    pcMap = substitute("&1,&2,&3", pcMap, ttGenericMap.gKey, ttGenericMap.gValue).
  end.
  
  pcMap = trim(pcMap, ",").
end procedure.
