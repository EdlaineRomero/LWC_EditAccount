/************************
* Trigger para validar conta antes de inserir ou atualizar os dados
* Create Edlaine Garcia Magalhães (edlaineromero@gmail.com)
* 
* Classe de teste : TriggerAccount_tst 
* 
* @Version					Date				User				Info
* 	1.0						2023-11-23			Edlaine Garcia		Create Trigger	
*/

trigger TriggerAccount on Account (before insert,before update,after insert) {
    if (Trigger.isBefore) {
        for(Account acc : trigger.new){
            
            if(acc.type == 'CPF'){
                if(acc.accountNumber != null && acc.accountNumber != ''){
                    if(!Utils.validaCPF(acc.accountNumber.replace('.','').replace('-',''))){
                        acc.addError('Número do cliente é inválido.\nPor favor preeencha um CPF valido');
                    }
                }else{
                    acc.addError('Número do cliente vazio. \nPor favor preencha o campo com CPF valido.');
                }
            }
            if(acc.type == 'CNPJ'){
                if(acc.accountNumber != null && acc.accountNumber != ''){
                    if(!Utils.validaCNPJ(acc.accountNumber.replace('.','').replace('/','').replace('-',''))){
                        acc.addError('Número do cliente é inválido.\nPor favor preeencha um CNPJ valido');
                    }
                }else{
                    acc.addError('Número do cliente vazio. \nPor favor preencha o campo com CNPJ valido.');
                }
            }            
            
        }
    }
    if(Trigger.isAfter && Trigger.isInsert){        
            AccountController.checkRecordType(trigger.new);
       
    }
}