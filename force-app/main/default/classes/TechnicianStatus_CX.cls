public with sharing class TechnicianStatus_CX {

    /**
     *  This Extension Controller is used to extend
     *  the functionality of the TechnicianStatusExtended
     *  page. It includes multiple methods used to redirect
     *  users to Contact edit pages. It also includes an
     *  attendeeList string which is built when a user
     *  hovers over one of the Course Delivery Dates
     *  listed in the Course Listing table.
     */

    private final Contact contact;
    private ApexPages.StandardController sController;

    // Constructor used to get the Account record
    public TechnicianStatus_CX(ApexPages.StandardController stdController) {
        sController = stdController;
        this.contact = (Contact)stdController.getRecord();
    }

    // This method returns the results from the call to the edit action
    // on the StandardController which returns a PageReference associated
    // with the Contacts standard edit page. It is basically the same
    // thing as calling the edit action on the Visualforce page, except
    // we are doing the call in the Apex code. The advantage to doing it
    // this way, is we could also do additional things here in the code
    // before we returned the PageReference.
    public PageReference editContact2() {
        return sController.edit();
    }

    // This method redirects the user to the edit page by creating
    // a PageReference and specifying the partial URL; It also
    // includes the retURL parameter in the URL so that if the user
    // cancels from the Edit page, they will be redirected back
    // to the TechnicianStatus page and not the Home page
    public PageReference editContact3() {
        String retUrl = '/apex/TechnicianStatusPage?id=' + contact.Id;
        return new PageReference('/' + contact.Id + '/e' + '?retURL=' + retUrl);
    }

    // List of Course Attendees associated with the Course Delivery Date that the user hovers over
    public String getAttendeeList() {
        String cdId = ApexPages.currentPage().getParameters().get('courseDeliveryId');
        return buildAttendeeList(cdId);
    }

    public String buildAttendeeList(String cdId) {
        String retString;
        if (!String.isBlank(cdId)) {
            Integer count = 0;
            List<Course_Attendee__c> courseAttendees = new List<Course_Attendee__c>([
                                          SELECT Student__r.Name
                                            FROM Course_Attendee__c
                                           WHERE Course_Delivery__c = :cdId]);
            for (Course_Attendee__c ca : courseAttendees) {
                if (count == 0) {
                    retString = 'Attendees: ';
                    count++;
                }
                if (ca.Student__r.Name != null) {
                    if (count < courseAttendees.size()) {
                        retString = retString + ca.Student__r.Name + ', ';
                    } else {
                        retString = retString + ca.Student__r.Name;
                    }
                    count++;
                }
            }
        }
        return retString;
    }
}