@isTest
private class BCCustomParseTests {

    private static String getTestXml(String staticResourceName) {
        StaticResource sr = [Select s.body From StaticResource s where name =: staticResourceName];
        String xml = sr.body.toString();
        return xml;
    }
    
    static testMethod void PayNetTest1() {
        
        forseva1.BusinessConnectTestUtil.initializeReferenceData();
        
        BCPayCustomParse ecp = new BCPayCustomParse();
        
        String xml = getTestXml('PayNetXML');
               
        
        Account ac = new Account(name='Test AC 1',billingstreet='29 S. LaSalle', billingcity='Chicago', billingState='Illinois',
                                   billingPostalCode='30004',
                                   forseva1__Credit_Review_Date__c = system.Today());
        insert ac;
        
        forseva1__PaynetCreditHistoryReport__c ecc = (forseva1__PaynetCreditHistoryReport__c) ecp.parseAndScore(ac.id, null, null, xml);
        
                
    }
    
    static testMethod void ConsumerParseTest() {
        
        forseva1.BusinessConnectTestUtil.initializeReferenceData();
        
        BCEFXConsumerCustomParse ecp = new BCEFXConsumerCustomParse();
        
        String xml = getTestXml('EFXConsumerXML');
        
        Account ac = new Account(name='Test AC 1',billingstreet='29 S. LaSalle', billingcity='Chicago', billingState='Illinois',
                                   billingPostalCode='30004',
                                   forseva1__Credit_Review_Date__c = system.Today());
        insert ac;
        
        forseva1__EquifaxConsumer__c ecc = (forseva1__EquifaxConsumer__c) ecp.parseAndScore(ac.id, null, null, xml);
    }   
}