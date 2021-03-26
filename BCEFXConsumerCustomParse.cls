global class BCEFXConsumerCustomParse implements forseva1.CustomParsing {
    global SObject parseAndScore(ID accountId, ID personId, String parameterString, String xml) {
    
        String serstr = null;        
        forseva1.ConsumerReportService crs = new forseva1.ConsumerReportService(xml,'Equifax');
        
        Account acct = [select id from account where id = :accountId];
        
        forseva1__DataProviderProduct__c efxConDP = [select id from forseva1__DataProviderProduct__c where name = 'Equifax Consumer Credit'];
        forseva1__EquifaxConsumer__c efxCon;
        efxCon = new forseva1__EquifaxConsumer__c();
        efxCon.forseva1__Data_Provider_Product__c = efxConDP.id;
        efxCon.forseva1__Account__c = accountId;

        try {
            System.debug(System.LoggingLevel.Error, 'handle EFXConsumer...');        
            
            String fileSince = crs.getNodeValue('EfxTransmit/EfxReport/USConsumerCreditReports/USConsumerCreditReport/USHeader/USCreditFile/FileSinceDate/');
            if (fileSince != null) {
                    Date startDate = date.parse(fileSince);
                    Integer fileAge = System.Today().year() - startDate.year();
                    efxCon.Credit_Report_Infile_Years__c = fileAge;
            }
            
            
        }
        catch (Exception e) {
            System.debug('Failed to parse InFilesince - EquifaxCon.  Continue processing...');
        }
        
        
                
        System.debug(System.Logginglevel.ERROR, ' serialized xml=' + serstr);
        return efxCon;
    }
    
    
    
}