 
/*------------------------------------------------------------------------
   File        : ProIntListTest.p 
   Syntax      : 
   Author(s)   : valentin.duricu
   Created     : Sat Nov 25 13:26:21 EET 2017
   Notes       : 
 ----------------------------------------------------------------------*/

using Progress.Lang.*.
using OpenEdge.Core.Assert from propath.

block-level on error undo, throw.

define variable hProIntList as handle no-undo.

@Setup.
procedure setUpProcedure:
  /*------------------------------------------------------------------------------
          Purpose:                                                                      
          Notes:                                                                        
  ------------------------------------------------------------------------------*/
  run ProList/ProIntList.p persistent set hProIntList.
end procedure.  

@TearDown.
procedure tearDownProcedure: 
  /*------------------------------------------------------------------------------
          Purpose:                                                                      
          Notes:                                                                        
  ------------------------------------------------------------------------------*/
  delete object hProIntList no-error.
end procedure. 

@Test.  
procedure TestemptyList: 
  /*------------------------------------------------------------------------------
          Purpose:                                                                      
          Notes:                                                                        
  ------------------------------------------------------------------------------*/
  define variable iSize    as integer no-undo.
  define variable lIsEmpty as logical no-undo.

  run sizeOf in hProIntList (output iSize).
  run isEmpty in hProIntList (output lIsEmpty).
  Assert:Equals(iSize, 0).
  Assert:Equals(lIsEmpty, true).
  
  run push in hProIntList (input 1).
  run sizeOf in hProIntList (output iSize).
  run isEmpty in hProIntList (output lIsEmpty).
  Assert:Equals(iSize, 1).
  Assert:Equals(lIsEmpty, false).
  
  run emptyList in hProIntList.
  
  run sizeOf in hProIntList (output iSize).
  run isEmpty in hProIntList (output lIsEmpty).
  Assert:Equals(iSize, 0).
  Assert:Equals(lIsEmpty, true).
end procedure.

@Test.  
procedure TestindexOf: 
  /*------------------------------------------------------------------------------
          Purpose:                                                                      
          Notes:                                                                        
  ------------------------------------------------------------------------------*/
  define variable iPosition as integer no-undo.
  define variable iSize     as integer no-undo.
  
  run sizeOf in hProIntList (output iSize).
  Assert:Equals(iSize, 0).
  
  run indexOf in hProIntList (input 2, output iPosition).
  Assert:Equals(iPosition, 0).
  
  run push in hProIntList (input 1).
  run push in hProIntList (input 3).
  run push in hProIntList (input 5).
  run push in hProIntList (input 2).
  
  run indexOf in hProIntList (input 3, output iPosition).
  Assert:Equals(iPosition, 2).
  run indexOf in hProIntList (input 2, output iPosition).
  Assert:Equals(iPosition, 4).
  run sizeOf in hProIntList (output iSize).
  Assert:Equals(iSize, 4).
end procedure.

@Test.  
procedure TestinsertAt: 
  /*------------------------------------------------------------------------------
          Purpose:                                                                      
          Notes:                                                                        
  ------------------------------------------------------------------------------*/
  define variable iSize     as integer no-undo.
  define variable iPosition as integer no-undo.
  
  run sizeOf in hProIntList (output iSize).
  Assert:Equals(iSize, 0).
  
  run insertAt in hProIntList (input 3, input 100).
  run indexOf in hProIntList (input 100, output iPosition).
  Assert:Equals(iPosition, 1).
  
  run sizeOf in hProIntList (output iSize).
  Assert:Equals(iSize, 1).
end procedure.

@Test.  
procedure TestisEmpty: 
  /*------------------------------------------------------------------------------
          Purpose:                                                                      
          Notes:                                                                        
  ------------------------------------------------------------------------------*/
  define variable iSize    as integer no-undo.
  define variable lIsEmpty as logical no-undo.

  run sizeOf in hProIntList (output iSize).
  run isEmpty in hProIntList (output lIsEmpty).
  Assert:Equals(iSize, 0).
  Assert:Equals(lIsEmpty, true).
end procedure.

@Test.  
procedure TestnewList: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

end procedure.

@Test.  
procedure Testpop: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

end procedure.

@Test.  
procedure Testpush: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

end procedure.

@Test.  
procedure TestremoveAt: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

end procedure.

@Test.  
procedure Testshift: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

end procedure.

@Test.  
procedure TestsizeOf: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

end procedure.

@Test.  
procedure TesttoString: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

end procedure.

@Test.  
procedure Testunshift: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

end procedure.

@Test.  
procedure TestvalueAt: 
/*------------------------------------------------------------------------------
        Purpose:                                                                      
        Notes:                                                                        
------------------------------------------------------------------------------*/

end procedure.
