global class BCPayCustomParse implements forseva1.CustomParsing {
    global SObject parseAndScore(ID accountId, ID personId, String parameterString, String xml) {
    
        String serstr = null;        
        forseva1.ConsumerReportService crs = new forseva1.ConsumerReportService(xml,'Equifax');
        
        Account acct = [select id from account where id = :accountId];
        
        forseva1__DataProviderProduct__c payDP = [select id from forseva1__DataProviderProduct__c where name = 'PayNet Credit History Report'];
        forseva1__PaynetCreditHistoryReport__c pay;
        pay = new forseva1__PaynetCreditHistoryReport__c();
        pay.forseva1__Data_Provider_Product__c = payDP.id;
        pay.forseva1__Account__c = accountId;

        try {
            System.debug(System.LoggingLevel.Error, 'handle PayNet...');        
            List<forseva1.GDomNode> allInq = crs.getAllNodes('response/xml_root/report/report_data/inquiries');
            Integer inqCount = 0;
            
            for (forseva1.GDomNode nd : allInq) {
                String inqbyMonth = crs.getNodeValue('inquiry', nd);
                //System.Debug('@@@RSP - InqDate listed = ' + inqbyMonth);   
                //the first one should always be the newest
                if(inqCount == 0 || inqbyMonth != null) {
                    pay.Credit_Inquiries_inthepastMonth__c = Integer.ValueOf(inqbyMonth);
                }
                inqCount += 1;
                
            }
            
            
        }
        catch (Exception e) {
            System.debug('Failed to parse inquiries - PayNet.  Continue processing...');
        }
        
        
        //System.debug('@@@RSP - Pay = ' + pay);        
        System.debug(System.Logginglevel.ERROR, ' serialized xml=' + serstr);
        return pay;
    }
    
    
    
    
}