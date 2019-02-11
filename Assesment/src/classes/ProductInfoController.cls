public class ProductInfoController {
    @AuraEnabled
    public static Case getCaseInfo(Id caseId){
        return [SELECT Id,ContactId,Contact.Name, Contact.Home_Country__c,Contact.Product__c FROM Case WHERE Id =:caseId];
    }
    
    @AuraEnabled
    public static List<Service_Charges__c> getProductInfo(String productId, String country)
    {
        List<Service_Charges__c> productInfo = new List<Service_Charges__c>();
        //Contact cont = [Select id, Product__c, Home_Country__c from Contact where Id=:contactId];
        if(productId != null && country != null){
            productInfo = [SELECT Id, Service__r.Name, Cost__c, Country__c, Product__r.Name, Percentage_Cost__c
                           FROM Service_Charges__c 
                           WHERE Product__c=:productId And 
                           		 Country__c =: country];
        }
        return productInfo;
    }
        
}