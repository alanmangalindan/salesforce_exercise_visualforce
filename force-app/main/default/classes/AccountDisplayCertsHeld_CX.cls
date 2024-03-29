public with sharing class AccountDisplayCertsHeld_CX {
    /**
     *  This Extension Controller is used to populate
     *  a table of Certifications Held that are
     *  related to a specific Account and displayed
     *  in-line on the detail page for that Account
     */

    private final Account acct;

    // Constructor used to get the Account record
    public AccountDisplayCertsHeld_CX(ApexPages.StandardController stdController) {
        this.acct = (Account) stdController.getRecord();
    }

    public List<Certification_Held__c> results {
        get {
            return [SELECT Id, Certification__r.Name, Name, Date_Achieved__c, Certified_Professional__r.Name
                      FROM Certification_Held__c
                     WHERE Certified_Professional__r.AccountId = :acct.Id
                   ORDER BY Certified_Professional__r.Name];
        }
        set;
    }
}