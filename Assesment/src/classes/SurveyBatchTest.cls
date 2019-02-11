@istest
public class SurveyBatchTest {
    
    Private static void setupData(){
        Account ac = new Account(name = 'Test Account');
        insert ac;
        
        Contact cont = new Contact (lastname = 'khan',
                                   email = 'rk.test@test.com',
                                   AccountId = ac.id,
                                   language__c = 'en',
                                   survey_date__c = system.today());
        insert cont;
        
    }
    
    @istest
    private static void surveyBatchTest()
    {
        setupData();
        test.startTest();
        System.schedule('Customer Survey', '0 0 12 1 * ? *',new ScheduleSurveyBatch());
        test.stopTest();
        
        //System.assert([Select id from Contact where survey_date__c = null].size() >0);
    }

}