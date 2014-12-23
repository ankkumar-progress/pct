ROUTINE-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.*.
USING OpenEdge.DataAdmin.Binding.ITableDataMonitor FROM PROPATH. 

CLASS rssw.pct.LoadDataLogger IMPLEMENTS ITableDataMonitor: 
  DEFINE VARIABLE errors AS LONGCHAR NO-UNDO.

    define public property bailed as logical no-undo
        get.
        set.
        
    define public property expectedRecords as int64 no-undo
        get.
        set.
        
    define public property FileName as character no-undo 
        get. 
        set.   
                
    define public property TaskName as character no-undo 
        get. 
        set.   
   
    define public property IsLoad as logical  no-undo 
        get. 
        set.  
        
    define public property LogTime as datetime-tz  no-undo 
        get. 
         
    define public property StartTime as datetime-tz  no-undo 
        get. 
        
    define public property EndTime as datetime-tz  no-undo 
        get. 
        
    define public property NumSharedTables as integer no-undo 
        get. 
     
    define public property NumTenantTables as integer no-undo 
        get. 
    
    define public property NumGroupTables as integer no-undo 
        get. 
    
    define public property NumProcessedSharedTables as integer no-undo 
        get. 
     
    define public property NumProcessedTenantTables as integer no-undo 
        get. 
    
    define public property NumProcessedGroupTables as integer no-undo 
        get. 
    
    define public property NoLobs as logical no-undo 
        get. 
        set.    
        
    define public property AnyError as logical no-undo 
        get. 
        set.
        
    define public property ErrorMessage as char no-undo 
        get. 
        set.
        
    define public property Interval as int no-undo 
        get. 
        set.    
    
    define public property IsComplete as log no-undo 
        get. 
        set.    
    
    define public property LogType as char no-undo 
        get. 
        set.
    
    define public property Cancel as logical no-undo 
        get.
        set. 
        
    define public property ConnectionUrl as character no-undo 
        get.
        set. 
        
    define public property CheckFiles as logical  no-undo 
        get. 
        set. 
    
    define public property AnyFileExists as logical  no-undo 
        get.
     
    define public property Slash as character no-undo 
        get. 
        set.    

    method public void AddSharedTables(pcPath as char, table-handle htbl):
    
    end method.
    
    method public void AddGroupTables(pcPath as char, pcGroupdir as char,  table-handle htbl):
    
    end method.
    
    method public void AddTenantTables(pcPath as char, pcTenant as char, table-handle htbl):
    
    end method.
 
    method public void Export():
    
    end method.
    
    /** 
       the actual file name used in the dump may differ, since the we 
       dump logic may change slashes and possibly also differences with relative 
       name and full path (?)  so we pass both owner and file at start */ 
    method public void StartTable(ptable as char, ptype as character,powner as char,pfile as char):

    end method.
    
    method public void EndTable(pname as character):

    end method.
  
    method public void EndTable(pname as character,numrows as int64):

    end method.
    
    method public logical CountRow(pname as character):

    end method. 

    METHOD PUBLIC LONGCHAR getErrors ():
      RETURN errors.
    END METHOD.

    /** called with any error logger may store all or just keep track of any  */
    method public void AddTableError(pname as character,e as Error):
      DEFINE VARIABLE zz AS INTEGER NO-UNDO.
    
      this-object:anyError = true.
      DO zz = 1 TO e:NumMessages:
        THIS-OBJECT:AddTableError(pname, e:GetMessage(zz)).
      END.
    end method.

    /** called with any error logger may store all or just keep track of any  */
    method public void AddTableError(pname as character,msg as char):
      this-object:anyError = true.    
      errors = errors + msg + "~n".
    end method.
    
    /** set expected num rows   */
    method public void SetTableExpectedNumRows(pname as character,pinum as int64 ):
      this-object:expectedRecords = piNum.    
    end method.
    
    /* set bailed so Endtable can decide whther to set isComplete true false
       when less than expected     */
    method public logical SetTableBailed(pname as character):
      this-object:bailed = true.
    end method. 
    
    method public void EndTask():
    end method.
  
    method public void BindFiles(h as handle):
    
    end method.

END CLASS.