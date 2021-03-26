public with sharing class BCEFXConsumerCreditReview{
    
    Account m_acct;
    
    public BCEFXConsumerCreditReview(ApexPages.StandardController stdController) {
        m_acct = (Account) stdController.getRecord();
    }
    
    public ApexPages.PageReference startCreditPull() {
        try {
            //credit policy id for Paynet
            List<forseva1__CreditPolicy__c> cplist = [select id from forseva1__CreditPolicy__c where name = 'US PayNet'];      

            //Account a = new Account(id=m_acct.ID, App_Start_Time__c = m_App_Start_Time);
            Account acct = [Select id, forseva1__Credit_Policy__c from Account where id =: m_acct.Id LIMIT 1];
            
            if (cplist.size() != 0) {
                for (forseva1__CreditPolicy__c cp : cplist){
                    if (acct.forseva1__Credit_Policy__c != cp.id) {
                        acct.forseva1__Credit_Policy__c  = cp.id;
                        update acct;
                    }
                }
            }
            
            //  PageReference pqPage = Page.forseva1__CreditReview;
            //  PageReference pqPage = Page.forseva1__AccountPrequalification;
            //  PageReference pqPage = Page.forseva1__AccountVerificationList;
            PageReference pqPage = Page.forseva1__ConsumerCreditReportRequest;
            pqPage.getParameters().put('fromId', acct.Id);
            pqPage.getParameters().put('parameterString', 'accountId:' + acct.Id);
            pqPage.setRedirect(true);   
            //pqPage.getParameters().put('id', acct.Id);
            return pqPage; 
            
        }
        catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return ApexPages.currentPage();         
        }

    }
    
    
    
}