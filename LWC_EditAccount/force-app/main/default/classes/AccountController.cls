/************************
* Classe Controller Account
* Create Edlaine Garcia Magalhães (edlaineromero@gmail.com)
* 
* Classe de teste : AccountController_tst 
* 
* @Version					Date				User				Info
* 	1.0						2023-11-23			Edlaine Garcia		Create Trigger	
*/
public class AccountController{
    
    public static void checkRecordType(List<Account> lstAccount){
        
        Map < Integer, List < Account >> Lotes  = geraLote(lstAccount);
        for ( Integer key: Lotes.keySet() ) {                           
            for(Account acc: Lotes.get( key )){                
                if(acc.RecordType.Name == 'Parceiro'){        
                    createOpp(acc);
                }else if(acc.RecordType.Name == 'Consumidor final'){
                    createTask(acc);
                }
            }
        }
        
        
    }
    
    public static void createOpp(Account account){
        try{
            Opportunity opp = new Opportunity();
            opp.AccountId = account.Id;            
            opp.Name = account.Name +'– opp Parceiro';
            opp.CloseDate = System.today() + 30;
            opp.StageName = 'Qualification';
            insert opp;
            
            CustomNotificacao.userNotification('Sucesso:', 'Oportunidade criada com sucesso', account.id);
        }catch(Exception e){
            CustomNotificacao.userNotification('ERRO:', e.getMessage(), account.id);
            System.debug(LoggingLevel.ERROR, 'ERRO: '+e.getMessage());            
        }
        
    }
    public static void createTask(Account account){
        try{
            Task task = new Task();            
            task.Subject = 'Consumidor Final';
            task.WhatId = account.Id;
            task.Status= 'Not Started';
            task.Priority = 'Normal';
            
            insert task;
            
            CustomNotificacao.userNotification('Sucesso:', 'Tarefa criada com sucesso', account.id);
            
        }catch(Exception e){
            CustomNotificacao.userNotification('ERRO:', e.getMessage(), account.id);
            System.debug(LoggingLevel.ERROR, 'ERRO: '+e.getMessage());            
        }
        
    }
    
    public static  Map < Integer, List < Account >> geraLote(List<Account> lstAccount){
        List<Account> listAccount = [Select id,RecordType.Name,Name from Account where id= :lstAccount];
        Map < Integer, List < Account >> Lotes = new Map < Integer, List < Account >> ();
        List < Account > tempObj = new List < Account > ();
        integer contador = 0;
        integer lote = 100;
        
        for ( Account obj: listAccount ) {
            
            
            tempObj.add( obj );
            if ( tempObj.size() == lote ) {                
                List < Account > tempObjCast = new List < Account > ();
                tempObjCast.addAll( tempObj );
                Lotes.put( contador, tempObjCast );
                contador++;
                tempObj.clear();
            }
            
        } 
        
        if ( tempObj.size() > 0 && tempObj.size() < lote ) {
            List < Account > tempObjCast = new List < Account > ();
            tempObjCast.addAll( tempObj );
            Lotes.put( contador, tempObjCast );
        }
        
        return Lotes;
        
    }
    
}