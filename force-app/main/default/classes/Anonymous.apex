//Batch
Id batchJobId = Database.executeBatch(new PDP_Batch(), 200);

//SessionId
System.debug(UserInfo.getOrganizationId()+''+UserInfo.getSessionId().substring(15));

DELETE [SELECT Id FROM Lead];


