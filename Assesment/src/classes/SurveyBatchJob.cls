global class SurveyBatchJob  implements Database.Batchable<sObject>{
    
    global final String Query;
    private Id emailTemplate {
        get{ 
            
            if(emailTemplate == null){ 
                emailTemplate= [Select id from EmailTemplate where developername='Customer_Survey' and isactive = true].id;
            }
            return emailTemplate;
        } set;}
    
    global SurveyBatchJob(String q){
        
        Query=q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope){
        
        List<Messaging.SingleEmailMessage> lstMsgs = new List<Messaging.SingleEmailMessage>();
        List<Contact> contacts = (List<Contact>)scope;
        for(Contact c : contacts){
            Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
            msg.setTemplateId(emailTemplate);
            msg.setSaveAsActivity(false);
            msg.setWhatId( c.id );
            msg.setTargetObjectId(c.id);
            lstMsgs.add(msg);
            
            // set survey date to null
            c.survey_date__c = null;
        }
        if(limits.getLimitEmailInvocations() - limits.getEmailInvocations() > 0){
            Messaging.sendEmail(lstMsgs);
            update contacts ;
        }
    }
    
    global void finish(Database.BatchableContext BC){
    }
}