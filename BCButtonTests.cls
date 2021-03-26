@isTest
private class BCButtonTests {
   
    static testMethod void VerifyPaynet() {
        
        setUpPolicies();
        Account acct = new Account();
        acct.Name = 'Test Account1';
        insert acct;
        
        Test.startTest ();
        BCPaynetVerify con = new BCPaynetVerify(new ApexPages.StandardController(acct));
        con.startCreditPull();
        Test.stopTest();
        
    }

    static testMethod void VerifyLN() {
        
        setUpPolicies();
        Account acct = new Account();
        acct.Name = 'Test Account1';
        insert acct;
        
        Test.startTest ();
        BCLNVerify con = new BCLNVerify(new ApexPages.StandardController(acct));
        con.startCreditPull();
        Test.stopTest();
        
    }
    
    static testMethod void ReviewPaynet() {
        
        setUpPolicies();
        Account acct = new Account();
        acct.Name = 'Test Account1';
        insert acct;
        
        Test.startTest ();
        BCPaynetReview con = new BCPaynetReview(new ApexPages.StandardController(acct));
        con.startCreditPull();
        Test.stopTest();
        
    }
    
    static testMethod void ReviewLN() {
        
        setUpPolicies();
        Account acct = new Account();
        acct.Name = 'Test Account1';
        insert acct;
        
        Test.startTest ();
        BCLNReviewCredit con = new BCLNReviewCredit(new ApexPages.StandardController(acct));
        con.startCreditPull();
        Test.stopTest();
        
    }

    static testMethod void ReviewEFX() {
        
        setUpPolicies();
        Account acct = new Account();
        acct.Name = 'Test Account1';
        insert acct;
        
        Test.startTest ();
        BCEFXCommercial con = new BCEFXCommercial(new ApexPages.StandardController(acct));
        con.startCreditPull();
        Test.stopTest();
        
    }     
    
    static testMethod void EFXConsumer() {
        setUpPolicies();
        Account acct = new Account();
        acct.Name = 'Test Account1';
        insert acct;
        
        Test.startTest ();
        BCEFXConsumerCreditReview con = new BCEFXConsumerCreditReview(new ApexPages.StandardController(acct));
        con.startCreditPull();
        Test.stopTest();
    }   
    
    static testMethod void LNConsumer() {
        setUpPolicies();
        Account acct = new Account();
        acct.Name = 'Test Account1';
        insert acct;
        
        Test.startTest ();
        BCLNConsumerCreditReview con = new BCLNConsumerCreditReview(new ApexPages.StandardController(acct));
        con.startCreditPull();
        Test.stopTest();
        
    }   
               
    static void setUpPolicies() {

        forseva1__DataProvider__c dp = new forseva1__DataProvider__c();
        dp.Name = 'Equifax Consumer';
        dp.forseva1__Password__c = 'xxxxx';
        dp.forseva1__Service_Timeout__c = 30;
        dp.forseva1__Environment__c = 'xxxx';
        dp.forseva1__Service_URL__c = 'xxx';
        dp.forseva1__User_Id__c = 'xxx';
        insert dp;
        
        forseva1__DataProviderProduct__c dpp = new forseva1__DataProviderProduct__c();
        dpp.Name = 'Equifax Consumer Credit';
        dpp.forseva1__Data_Provider__c = dp.id;
        dpp.forseva1__Days_Valid__c = 30;
        dpp.forseva1__Data_Provider__c = dp.id;
        insert dpp;
        
        forseva1__DataProvider__c dp2 = new forseva1__DataProvider__c();
        dp2.Name = 'Equifax';
        dp2.forseva1__Password__c = 'xxxxx';
        dp2.forseva1__Service_Timeout__c = 30;
        dp2.forseva1__Environment__c = 'xxxx';
        dp2.forseva1__Service_URL__c = 'xxx';
        dp2.forseva1__User_Id__c = 'xxx';
        insert dp2;
        
        forseva1__DataProviderProduct__c dpp2= new forseva1__DataProviderProduct__c();
        dpp2.Name = 'Equifax Business Principal Report';
        dpp2.forseva1__Data_Provider__c = dp2.id;
        dpp2.forseva1__Days_Valid__c = 30;
        dpp2.forseva1__Data_Provider__c = dp2.id;
        insert dpp2;
        
        forseva1__CreditPolicy__c cp = new forseva1__CreditPolicy__c();
        cp.forseva1__Create_Family_Tree_Ancestor_Accounts__c = false;
        cp.forseva1__Default_Policy__c = true;
        cp.Name = 'myUnitTestzzzzzzz';
        cp.forseva1__First_Credit_Review_Product__c = dpp2.id;
        cp.forseva1__First_Prequalification_Product__c = dpp2.id;
        cp.forseva1__First_Verification_Product__c = dpp2.id;
        cp.forseva1__First_Consumer_Product__c = 'Equifax Consumer Credit';
        insert cp;
        
        List<forseva1__CreditPolicy__c> cplist = [select id from forseva1__CreditPolicy__c where name = 'US PayNet'];      
        if (cplist.size() == 0) {
            forseva1__CreditPolicy__c us_cp = new forseva1__CreditPolicy__c(name = 'US PayNet', forseva1__Default_Policy__c = true, forseva1__First_Credit_Review_Product__c = 'test', forseva1__First_Prequalification_Product__c='test', forseva1__First_Verification_Product__c='test', forseva1__First_Consumer_Product__c = dpp.id);
            insert us_cp;
        }

        cplist = [select id from forseva1__CreditPolicy__c where name = 'US LN'];      
        if (cplist.size() == 0) {
            forseva1__CreditPolicy__c canada_cp = new forseva1__CreditPolicy__c(name = 'US LN', forseva1__Default_Policy__c = false, forseva1__First_Credit_Review_Product__c = 'test', forseva1__First_Prequalification_Product__c='test', forseva1__First_Verification_Product__c='test');
            insert canada_cp;
        }
        
    }
}