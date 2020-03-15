public virtual class TriggerHandler {

    public virtual void run(){
        if(Trigger.isBefore && Trigger.isInsert){
            beforeInsert();
        }else if (Trigger.isAfter && Trigger.isInsert){
            afterInsert();
        }else if (Trigger.isBefore && Trigger.isUpdate){
            beforeUpdate();
        }else if (Trigger.isAfter && Trigger.isUpdate){
            afterUpdate();
        }else if (Trigger.isBefore && Trigger.isDelete){
            beforeDelete();
        }else if (Trigger.isAfter && Trigger.isDelete){
            afterDelete();
        }else if (Trigger.isBefore && Trigger.isUndelete){
            beforeUndelete();
        }
    }

    protected virtual void beforeInsert(){
        
    }
    protected virtual void afterInsert(){
        
    }
    protected virtual void beforeUpdate(){
        
    }
    protected virtual void afterUpdate(){
        
    }
    protected virtual void beforeDelete(){
        
    }
    protected virtual void afterDelete(){
        
    }
    protected virtual void beforeUndelete(){
        
    }

}
