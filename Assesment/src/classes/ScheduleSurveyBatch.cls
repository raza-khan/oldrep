global class ScheduleSurveyBatch implements Schedulable {
    
    global void execute(SchedulableContext sc) { 
        string query = 'SELECT Id, FirstName, LastName, AccountId, Name, Languages__c, survey_date__c FROM Contact where survey_date__c != null and survey_date__c <= TODAY'; 
        System.debug('query:'+ query);
        ID BatchId = Database.executeBatch(new SurveyBatchJob(query), 200);
        
    }
    
}