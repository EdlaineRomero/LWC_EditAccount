/************************
* Batch CleacAccountInactive para limpar as contas inativas
* Create Edlaine Garcia Magalhães (edlaineromero@gmail.com)
* 
* Classe de teste : AccountController_tst 
* 
* @Version					Date				User				Info
* 	1.0						2023-11-23			Edlaine Garcia		Create Trigger	
*/
public class CleanAccountInactive implements Database.Batchable<sObject>{
    
    public final String query;
    
    public CleanAccountInactive(){
        query = 'Select id from Account where Inativa__c = false';
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC){     
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext info, List<Account> scope){
        List<Task> liTask = [SELECT id,AccountId, CreatedDate FROM task WHERE AccountId =:scope and CreatedDate = LAST_90_DAYS];
        List<Opportunity> liOpp = [select id,AccountId from Opportunity where AccountId =:scope and CloseDate = LAST_90_DAYS and StageName = 'Closed Won'];
        List<Opportunity> liOppNegotiation = [select id,AccountId from Opportunity where AccountId =:scope and StageName='Negotiation/Review' ];
        
        List<Account> accsToUpdate = new List<Account>();
        for(Account a : scope){ 
            Boolean taskInativa = true;
            Boolean oppCloseDateInativa = true;
            Boolean oppNegotiationInativa = true;
            for(Task task : liTask){
                if(task.AccountId == a.Id){
                    taskInativa = false;
                }
            }
            
            for(Opportunity oppCloseDate :liOpp){
                if(oppCloseDate.AccountId == a.id){
                    oppCloseDateInativa = false;
                }
            }
            
            for(Opportunity oppNegotiation :liOppNegotiation){
                if(oppNegotiation.AccountId == a.id){
                    oppNegotiationInativa = false;
                }
            }
            
            if(taskInativa || oppCloseDateInativa || oppNegotiationInativa){
                a.Inativa__c = true;
            }
            
            accsToUpdate.add(a); 
        } 
        update accsToUpdate; 
    }     
    public void finish(Database.BatchableContext info){   
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] {'edlaineromer@gmail.com'});
        mail.setReplyTo('edlaineromer@gmail.com');
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Batch Process Completed');
        mail.setPlainTextBody('Batch Process has completed');
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    } 
}