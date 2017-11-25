/**
 * ProList/ProGenericList.i
 *
 * OpenEdge implementation of an Abstract Data Type representing an ordered list.
 */
define variable iKey as integer no-undo initial 1.

{ttGenericList.i &value-datatype={&listType}}

function castTo returns {&listType} private
  (input pcValue as character) forward.

/* --- Main Block --- */
/* Nothing here to do */
/* --- End Main Block --- */

procedure newList:
  /**
   * Builds the ADT list from a given string list.
   *
   * @param character pcList The string list to be parsed.
   */
  define input  parameter pcList as character no-undo.
  
  define variable iCount as integer no-undo.
  
  run emptyList.
  do iCount = 1 to num-entries(pcList):
    run push (input castTo(entry(iCount, pcList))).
  end.
end procedure.

procedure sizeOf:
  /**
   * Returns the size of the list.
   *
   * @return piSize integer
   */
  define output parameter piSize as integer no-undo initial 0.
  
  piSize = iKey - 1.
  
/* OR */
/*  for each ttGenericList no-lock:*/
/*    piSize = piSize + 1.         */
/*  end.                           */
end procedure.

procedure isEmpty:
  /**
   * Checks if the list is empty.
   *
   * @return plIsEmpty logical
   */
  define output parameter plIsEmpty as logical no-undo.
  
  plIsEmpty = not temp-table ttGenericList:has-records.
end procedure.

procedure emptyList:
  /**
   * Empty the list.
   */
  empty temp-table ttGenericList.
  iKey = 1.
end procedure.

procedure push:
  /**
   * Pushes an element into the list.
   *
   * @param {&listType} pgValue The value to be pushed into the list.
   */
  define input  parameter pgValue as {&listType} no-undo.
  
  create ttGenericList.
  assign
    ttGenericList.gKey   = iKey
    iKey                 = iKey + 1
    ttGenericList.gValue = pgValue.
end procedure.

procedure pop:
  /**
   * Pops an element from the list.
   *
   * @return integer pgValue
   */
  define output parameter pgValue as {&listType} no-undo initial ?.
  
  find last ttGenericlist exclusive-lock no-error.
  
  if not available ttGenericList then
    return.
  
  assign
    pgValue = ttGenericList.gValue
    iKey    = iKey - 1.
  delete ttGenericList.
end procedure.

procedure insertAt:
  /**
   * Inserts an element into the list at the given position.
   *
   * @param integer piPosition The value to be pushed into the list.
   * @param {&listType} pgValue The value to be pushed into the list.
   */
  define input  parameter piPosition as integer     no-undo.
  define input  parameter pgValue    as {&listType} no-undo.
  
  for each ttGenericList exclusive-lock
    where ttGenericList.gKey >= piPosition
    by gKey desc:
    
    ttGenericList.gKey = ttGenericList.gKey + 1.
  end.
  
  if piPosition > iKey then
    piPosition = iKey.
  
  create ttGenericList.
  assign
    ttGenericList.gKey   = piPosition
    ttGenericList.gValue = pgValue
    iKey                 = iKey + 1.
end procedure.

procedure removeAt:
  /**
   * Removes an element from the list at the given position.
   *
   * @param integer piPosition The value to be pushed into the list.
   */
  define input  parameter piPosition as integer no-undo.
  
  find first ttGenericList exclusive-lock
    where ttGenericList.gKey = piPosition no-error.
    
  if not available ttGenericList then
    return.
  
  delete ttGenericList.
  for each ttGenericList exclusive-lock
    where ttGenericList.gKey > piPosition:
    ttGenericList.gKey = iKey - 1.
  end.
end procedure.

procedure shift:
  /**
   * Shifts the first element of the list.
   *
   * @return {&listType} pgValue
   */
  define output  parameter pgValue as {&listType} no-undo.
  
  find first ttGenericList exclusive-lock no-error.
  
  if not available ttGenericList then
    return.
    
  assign
    iKey    = iKey - 1
    pgValue = ttGenericList.gValue.
    
  delete ttGenericList.
    
  for each ttGenericList exclusive-lock
    where ttGenericList.gKey > 1:
    ttGenericList.gKey = ttGenericList.gKey - 1.
  end.
end procedure.

procedure unshift:
  /**
   * Inserts an element into the list on the first position.
   *
   * @param {&listType} pgValue The value to be pushed into the list.
   */
  define input  parameter pgValue as {&listType} no-undo.
  
  for each ttGenericList exclusive-lock
    by ttGenericList.gKey desc:
    ttGenericList.gKey = ttGenericList.gKey + 1.  
  end.
  
  create ttGenericList.
  assign
    iKey                 = iKey + 1
    ttGenericList.gValue = pgValue
    ttGenericList.gKey   = 1.
end procedure.

procedure indexOf:
  /**
   * Searches the position of the given element.
   *
   * @param {&listType} pgValue The value to be found in the list.
   *
   * @return integer piPosition
   */
  define input  parameter pgValue    as {&listType} no-undo.
  define output parameter piPosition as integer     no-undo initial 0.
  
  find first ttGenericList no-lock
    where ttGenericList.gValue = pgValue no-error.
    
  if not available ttGenericList then
    return.
  
  piPosition = ttGenericList.gKey.
end procedure.

procedure valueAt:
  /**
   * Returns the value at the given position
   *
   * @param integer piPosition The value to be pushed into the list.
   *
   * @return {&listType} pgValue
   */
  define input  parameter piPosition as integer     no-undo.
  define output parameter pgValue    as {&listType} no-undo initial ?.
  
  find first ttGenericList no-lock
    where ttGenericList.gKey = piPosition no-error.
    
  if not available ttGenericList then
    return.
    
  pgValue = ttGenericList.gValue.
end procedure.

procedure toString:
  /**
   * Returns the string representation of the list
   *
   * @return character pcList
   */
  define output parameter pcList as character no-undo.
  
  for each ttGenericList no-lock:
    pcList = substitute("&1,&2", pcList, ttGenericList.gValue).
  end.
  
  pcList = trim(pcList, ",").
end procedure.

function castTo returns {&listType} private
  (input pcValue as character):
   
  &if "{&listType}" = "character" &then
  return pcValue.
  &elseif "{&listType}" = "integer" &then
  return integer (pcValue).
  &elseif "{&listType}" = "decimal" &then
  return decimal (pcValue).
  &else
  return ?.
  &endif
    
end.