trigger Requisitions on Requisition__c (after update) 
{
	GoogleMirrorApprovalProcess handler = new GoogleMirrorApprovalProcess();
	handler.afterUpdate(Trigger.new, Trigger.oldMap);
}
