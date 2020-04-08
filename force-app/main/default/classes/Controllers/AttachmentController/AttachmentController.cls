public with sharing class AttachmentController {
    
    @AuraEnabled(cacheable=true)
    public static List<Attachment> getAttachmentsByOwnerId(String ownerId){
        if(ownerId != null){
            List<Attachment> attachments = [SELECT Id FROM Attachment WHERE ParentId = :ownerId];
            if(attachments != null && attachments.size() > 0){
                return attachments;
            } else {
                return null;
            }
        } else {
            throw new NullPointerException();
        }
    }

}
