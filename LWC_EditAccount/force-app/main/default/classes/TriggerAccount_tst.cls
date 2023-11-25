/************************
* Classe TriggerAccount_tst para contemplar a classe TriggerAccount
* Create Edlaine Garcia Magalhães (edlaineromero@gmail.com) 
* 
* @Version					Date				User				Info
* 	1.0						2023-11-23			Edlaine Garcia		Create Class	
*/
@isTest
public class TriggerAccount_tst {

    @isTest
    static void validaCPFVazio(){
        Account acc = new Account();
        acc.Name = 'teste 1';
        acc.Type ='CPF';
            
        test.startTest();
        Database.SaveResult result = Database.insert(acc, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Número do cliente vazio. \nPor favor preencha o campo com CPF valido.',
                             result.getErrors()[0].getMessage());
    }
     @isTest
    static void validaCPF(){
        Account acc = new Account();
        acc.Name = 'teste 1';
        acc.Type ='CPF';
        acc.AccountNumber ='090909';
            
        test.startTest();
        Database.SaveResult result = Database.insert(acc, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Número do cliente é inválido.\nPor favor preeencha um CPF valido',
                             result.getErrors()[0].getMessage());
    }
    
    @isTest
    static void validaCNPJVazio(){
        Account acc = new Account();
        acc.Name = 'teste 1';
        acc.Type ='CNPJ';
            
        test.startTest();
        Database.SaveResult result = Database.insert(acc, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Número do cliente vazio. \nPor favor preencha o campo com CNPJ valido.',
                             result.getErrors()[0].getMessage());
    }
    
      @isTest
    static void validaCNPJ(){
        Account acc = new Account();
        acc.Name = 'teste 1';
        acc.Type ='CNPJ';
        acc.AccountNumber ='090909';
            
        test.startTest();
        Database.SaveResult result = Database.insert(acc, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Número do cliente é inválido.\nPor favor preeencha um CNPJ valido',
                             result.getErrors()[0].getMessage());
    }
    @isTest
    static void insertAccount(){
        RecordType recordType = [Select id from RecordType where DeveloperName = 'Parceiro'];
        Account acc = new Account();
        acc.Name = 'teste 1';
        acc.Type ='CNPJ';
        acc.AccountNumber ='01.744.845/0001-54';
        acc.RecordTypeId = recordType.Id;
            
        test.startTest();
        insert(acc);
        Test.stopTest();
        
        Account accAssert = [Select id,name from Account where RecordType.Name = 'Parceiro'];
       
        System.assertEquals('teste 1',acc.Name);
    }
    
     @isTest
    static void insertAccountLote(){
        RecordType recordType = [Select id from RecordType where DeveloperName = 'Parceiro'];
        List<Account> listAccount = new List<Account>();
        for(Integer i =0; i<=100;i++){
            Account acc = new Account();
            acc.Name = 'teste '+i; 
            listAccount.add(acc);
        }       
            
        test.startTest();
        insert(listAccount);
        Test.stopTest();
        
        List<Account> listAccountAssert= [Select id from Account];
       
        System.assertEquals(101,listAccountAssert.size());
    }
}