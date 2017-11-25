/**
 * ProList/ProIntList.p
 *
 * OpenEdge implementation of an Abstract Data Type representing an ordered list.
 */
block-level on error undo, throw.

define variable iKey as integer no-undo initial 1.

{ttIntList.i}

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
    run push (input integer(entry(iCount, pcList))).
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
/*  for each ttIntList no-lock:*/
/*    piSize = piSize + 1.     */
/*  end.                       */
end procedure.

procedure isEmpty:
  /**
   * Checks if the list is empty.
   *
   * @return plIsEmpty integer
   */
  define output parameter plIsEmpty as logical no-undo.
  
  plIsEmpty = not temp-table ttIntList:has-records.
end procedure.

procedure emptyList:
  /**
   * Empty the list.
   */
  empty temp-table ttIntList.
  iKey = 1.
end procedure.

procedure push:
  /**
   * Pushes an element into the list.
   *
   * @param integer piValue The value to be pushed into the list.
   */
  define input  parameter piValue as integer no-undo.
  
  create ttIntList.
  assign
    ttIntList.iKey   = iKey
    iKey             = iKey + 1
    ttIntList.iValue = piValue.
end procedure.

procedure pop:
  /**
   * Pops an element from the list.
   *
   * @return integer piValue
   */
  define output parameter piValue as integer no-undo initial ?.
  
  find last ttIntlist exclusive-lock no-error.
  
  if not available ttIntList then
    return.
  
  assign
    piValue = ttIntList.iValue
    iKey    = iKey - 1.
  delete ttIntList.
end procedure.

procedure insertAt:
  /**
   * Inserts an element into the list at the given position.
   *
   * @param integer piPosition The value to be pushed into the list.
   * @param integer piValue The value to be pushed into the list.
   */
  define input  parameter piPosition as integer no-undo.
  define input  parameter piValue    as integer no-undo.
  
  for each ttIntList exclusive-lock
    where ttIntList.iKey >= piPosition
    by iKey desc:
    
    ttIntList.iKey = ttIntList.iKey + 1.
  end.
  
  if piPosition > iKey then
    piPosition = iKey.
  
  create ttIntList.
  assign
    ttIntList.iKey   = piPosition
    ttIntList.iValue = piValue
    iKey             = iKey + 1.
end procedure.

procedure removeAt:
  /**
   * Removes an element from the list at the given position.
   *
   * @param integer piPosition The value to be pushed into the list.
   */
  define input  parameter piPosition as integer no-undo.
  
  find first ttIntList exclusive-lock
    where ttIntList.iKey = piPosition no-error.
    
  if not available ttIntList then
    return.
  
  delete ttIntList.
  for each ttIntList exclusive-lock
    where ttIntList.iKey > piPosition:
    ttIntList.iKey = iKey - 1.
  end.
end procedure.

procedure shift:
  /**
   * Shifts the first element of the list.
   *
   * @return integer piValue
   */
  define output  parameter piValue as integer no-undo.
  
  find first ttIntList exclusive-lock no-error.
  
  if not available ttIntList then
    return.
    
  assign
    iKey    = iKey - 1
    piValue = ttIntList.iValue.
    
  delete ttIntList.
    
  for each ttIntList exclusive-lock
    where ttIntList.iKey > 1:
    ttIntList.iKey = ttIntList.iKey - 1.
  end.
end procedure.

procedure unshift:
  /**
   * Inserts an element into the list on the first position.
   *
   * @param integer piPosition The value to be pushed into the list.
   */
  define input  parameter piValue as integer no-undo.
  
  for each ttIntList exclusive-lock
    by ttIntList.iKey desc:
    ttIntList.iKey = ttIntList.iKey + 1.  
  end.
  
  create ttIntList.
  assign
    iKey             = iKey + 1
    ttIntList.iValue = piValue
    ttIntList.iKey   = 1.
end procedure.

procedure indexOf:
  /**
   * Searches the position of the given element.
   *
   * @param integer piValue The value to be found in the list.
   *
   * @return integer piPosition
   */
  define input  parameter piValue    as integer no-undo.
  define output parameter piPosition as integer no-undo initial 0.
  
  find first ttIntList no-lock
    where ttIntList.iValue = piValue no-error.
    
  if not available ttIntList then
    return.
  
  piPosition = ttIntList.iKey.
end procedure.

procedure valueAt:
  /**
   * Returns the value at the given position
   *
   * @param integer piPosition The value to be pushed into the list.
   *
   * @return integer piValue
   */
  define input  parameter piPosition as integer no-undo.
  define output parameter piValue    as integer no-undo initial ?.
  
  find first ttIntList no-lock
    where ttIntList.iKey = piPosition no-error.
    
  if not available ttIntList then
    return.
    
  piValue = ttIntList.iValue.
end procedure.

procedure toString:
  /**
   * Returns the string representation of the list
   *
   * @return character pcList
   */
  define output parameter pcList as character no-undo.
  
  for each ttIntList no-lock:
    pcList = substitute("&1,&2", pcList, ttIntList.iValue).
  end.
  
  pcList = trim(pcList, ",").
end procedure.