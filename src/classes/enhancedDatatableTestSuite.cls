public class enhancedDatatableTestSuite {

	    static testMethod void t4_CampaignMember_Edit2() {
	    
	    Test.startTest();
	    
	    User u = TestUtility.createTestUser([select id, name from Profile where name='Standard User' limit 1]);
	    
	    System.runAs(u) {
	    	
		    Campaign ca = new Campaign(name = 'PhillyPride');
		    insert ca;
		    Contact c = new Contact(FirstName ='Benny', LastName = 'Franklin__test');
		    insert c;
		    CampaignMember cm = new CampaignMember(ContactId = c.id, CampaignId = ca.id);
		    insert cm; 
		    
		    System.debug('CID' + c.id);
	    
			Test.setCurrentPage(Page.datatableDemo);
			EnhancedDatatableController edc = new EnhancedDatatableController();
			edc.objectName = 'CampaignMember';
			edc.requiredFieldName = 'CampaignId';
			edc.requiredFieldValue = ca.id;
			edc.columnString = 'Contact.FirstName,Contact.LastName,Status';
			edc.outerObjectId = 'ContactId';	
			edc.editable = true;
			edc.getOnLoad();
			System.assertNotEquals(edc.jsonData.indexOf('zzz'), -1);
			Test.setCurrentPage(Page.saveData);
			ApexPages.currentPage().getParameters().put(edc.requiredFieldName,edc.requiredFieldValue);
			ApexPages.currentPage().getParameters().put('id',cm.id);
			ApexPages.currentPage().getParameters().put('ContactzzzFirstName','Benny__test');  
			ApexPages.currentPage().getParameters().put('ContactzzzLastName','Franklin__test2');
			ApexPages.currentPage().getParameters().put('Status','Responded');
			ApexPages.currentPage().getParameters().put('outerobjectid',edc.outerObjectId);
			ApexPages.currentPage().getParameters().put('ContactId',c.id);
			System.debug('CID' + c.id);
			
			ApexPages.currentPage().getParameters().put('type',edc.objectName);
			ApexPages.currentPage().getParameters().put('oper','edit');
			EnhancedDatatableSaveController edsc = new EnhancedDatatableSaveController();
			
			edsc.saveData();
			CampaignMember new_cm = [SELECT id, Status from CampaignMember where Contact.LastName ='Franklin__test2' limit 1];	
			System.AssertEquals('Responded', new_cm.Status);
	    
	    }
	    
	    Test.stopTest();
	
	    }


 static testMethod void t1_Account_Add() {
	        
	    Test.startTest();
	    
	    Profile p = [select id, name from Profile where name='Standard User' limit 1];
	    
	    User u = TestUtility.createTestUser([select id, name from Profile where name='System Administrator' limit 1]);  
	    
	    System.runAs(u) {  
	    
			Test.setCurrentPage(Page.datatableDemo);
			EnhancedDatatableController edc = new EnhancedDatatableController();    
			edc.objectName = 'Account';
			edc.columnString = 'name';  
			edc.editable = true;  
			edc.getOnLoad();  
			Test.setCurrentPage(Page.saveData);
			ApexPages.currentPage().getParameters().put('name','FranklinB__test');
			ApexPages.currentPage().getParameters().put('type',edc.objectName);
			ApexPages.currentPage().getParameters().put('oper','add');
			EnhancedDatatableSaveController edsc = new EnhancedDatatableSaveController();
			edsc.saveData();
			System.assertEquals(1, [SELECT id from Account where name ='FranklinB__test'].size());		
	    
	    }
	    
	    Test.stopTest();
	
	    }



 static testMethod void t2_Account_Edit() {
	        
	    Account a = new Account(name = 'FranklinB__test');
	    insert a; 
	    
	    Test.startTest();
	    
	    User u = TestUtility.createTestUser([select id, name from Profile where name='System Administrator' limit 1]);
	    
	    System.runAs(u) {
	    
			Test.setCurrentPage(Page.datatableDemo);
			EnhancedDatatableController edc = new EnhancedDatatableController();
			edc.objectName = 'Account';
			edc.columnString = 'name';
			edc.editable = true;
			edc.getOnLoad();
			
			Test.setCurrentPage(Page.saveData);
			ApexPages.currentPage().getParameters().put('id',a.id);
			ApexPages.currentPage().getParameters().put('name','FranklinB__test2');
			ApexPages.currentPage().getParameters().put('type',edc.objectName);
			ApexPages.currentPage().getParameters().put('oper','edit');
			EnhancedDatatableSaveController edsc = new EnhancedDatatableSaveController();
			edsc.saveData();
			System.assertEquals(1, [SELECT id from Account where name ='FranklinB__test2'].size());		
	    
	    }
	    
	    Test.stopTest();
	
	    }


	  
 static testMethod void t3_CampaignMember_Add() {
	    
	    Campaign c = new Campaign(name = 'PhillyPride');
	    insert c;
	    
	    Test.startTest();
	    
	    User u = TestUtility.createTestUser([select id, name from Profile where name='System Administrator' limit 1]);
	    
	    System.runAs(u) {
	    
			Test.setCurrentPage(Page.datatableDemo);
			EnhancedDatatableController edc = new EnhancedDatatableController();
			edc.objectName = 'CampaignMember';
			edc.columnString = 'Contact.FirstName,Contact.LastName,Status';
			edc.filterString = 'where CampaignId = \'' + c.id + '\''; 
			edc.requiredFieldName = 'CampaignId';
			edc.outerObjectid = 'ContactId';
			edc.requiredFieldValue = c.id;    
			edc.editable = true;
			edc.getOnLoad();
			Test.setCurrentPage(Page.saveData);
			ApexPages.currentPage().getParameters().put(edc.requiredFieldName,edc.requiredFieldValue);
			ApexPages.currentPage().getParameters().put('ContactzzzFirstName','Benny__test');
			ApexPages.currentPage().getParameters().put('ContactzzzLastName','Franklin__test');			
			ApexPages.currentPage().getParameters().put('Status','Responded');			
			ApexPages.currentPage().getParameters().put('outerobjectid',edc.outerObjectId);
			ApexPages.currentPage().getParameters().put('type',edc.objectName);
			ApexPages.currentPage().getParameters().put('oper','add');
			EnhancedDatatableSaveController edsc = new EnhancedDatatableSaveController();
			
			edsc.saveData();
			CampaignMember cm = [SELECT id, Status from CampaignMember where Contact.LastName ='Franklin__test' limit 1];
			System.assertEquals('Responded', cm.status);
			
			   	
	    
	    }
	    
	    Test.stopTest();
	
	    }
	    
	    static testMethod void t4_CampaignMember_Edit() {
	    
	    Test.startTest();
	    
	    User u = TestUtility.createTestUser([select id, name from Profile where name='Standard User' limit 1]);
	    
	    System.runAs(u) {
	    	
		    Campaign ca = new Campaign(name = 'PhillyPride');
		    insert ca;
		    Contact c = new Contact(FirstName ='Benny', LastName = 'Franklin__test');
		    insert c;
		    CampaignMember cm = new CampaignMember(ContactId = c.id, CampaignId = ca.id);
		    insert cm; 
		    
		    System.debug('CID' + c.id);
	    
			Test.setCurrentPage(Page.datatableDemo);
			EnhancedDatatableController edc = new EnhancedDatatableController();
			edc.objectName = 'CampaignMember';
			edc.requiredFieldName = 'CampaignId';
			edc.requiredFieldValue = ca.id;
			edc.columnString = 'Contact.FirstName,Contact.LastName,Status';
			edc.outerObjectId = 'ContactId';	
			edc.editable = true;
			edc.getOnLoad();
			System.assertNotEquals(edc.jsonData.indexOf('zzz'), -1);
			Test.setCurrentPage(Page.saveData);
			ApexPages.currentPage().getParameters().put(edc.requiredFieldName,edc.requiredFieldValue);
			ApexPages.currentPage().getParameters().put('id',cm.id);
			ApexPages.currentPage().getParameters().put('ContactzzzFirstName','Benny__test');  
			ApexPages.currentPage().getParameters().put('ContactzzzLastName','Franklin__test2');
			ApexPages.currentPage().getParameters().put('Status','Responded');
			ApexPages.currentPage().getParameters().put('outerobjectid',edc.outerObjectId);
			ApexPages.currentPage().getParameters().put('ContactId',c.id);
			System.debug('CID' + c.id);
			
			ApexPages.currentPage().getParameters().put('type',edc.objectName);
			ApexPages.currentPage().getParameters().put('oper','edit');
			EnhancedDatatableSaveController edsc = new EnhancedDatatableSaveController();
			
			edsc.saveData();
			CampaignMember new_cm = [SELECT id, Status from CampaignMember where Contact.LastName ='Franklin__test2' limit 1];	
			System.AssertEquals('Responded', new_cm.Status);
	    
	    }
	    
	    Test.stopTest();
	
	    }
	    




}