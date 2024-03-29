public with sharing class AccountDisplayCertAttempts_CX {
    /**
     *  This Extension Controller is used to populate
     *  a table of In progress Certification Attempts
     *  related to a specific Account and displayed
     *  in-line on the detail page for that Account
     */

    private final Account acct;

    /** TODO #1: Declare a public Constructor named AccountDisplayCertAttempts_CX
     *           that includes an input parameter whose type is ApexPages.StandardController
     *           named stdController. Within the constructor assign the controller's
     *           instance acct variable the result of calling the
     *           getRecord method of the stdController and casting it to the Account type.
     */
    public AccountDisplayCertAttempts_CX(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
    }


    /** TODO #2: Declare a read-only property whose type is a List of Certification_Attempt__c
     *           sObjects, named results and have it include:
     *             -- an if statement that, if the results property is null
     *                -- Assign the results property to a new instance of a list of Certification_Attempt__c
     *                   sObjects that will accept as a parameter a SOQL query that:
     *                   -- Selects the Name, Certification_Candidate__r.Name, Certification_Element__r.Name fields
     *                   -- From the Certification_Attempt__c sObject
     *                   -- Where the value of the AccountId field of the Certification_Candidate__r sObject
     *                      equals the Id of the acct variable AND the Status__c field is NOT one of the following values:
     *                      'Complete/Pass' and 'Complete/Fail'.
     *                -- Return the results property
     *             Be sure to include the set property;
     */
    public List<Certification_Attempt__c> results {
        get {
            if (results == null) {
                results = new List<Certification_Attempt__c>([SELECT Name, Certification_Candidate__r.Name, Certification_Element__r.Name
                                                             FROM Certification_Attempt__c
                                                             WHERE Certification_Candidate__r.AccountId = :acct.Id
                                                             AND Status__c NOT IN ('Complete/Pass', 'Complete/Fail')]);
                
            }
            return results;
        }
        private set;
    }


}