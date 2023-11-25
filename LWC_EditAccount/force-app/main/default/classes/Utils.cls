/************************
* Classe Utils para metodos que podem ser utilizados para diversos objetos.
* Create Edlaine Garcia Magalhães (edlaineromero@gmail.com)
* 
* Classe de teste : Utils_tst 
* 
* @Version					Date				User				Info
* 	1.0						2023-11-23			Edlaine Garcia		Create Class	
*/
public class Utils {
    public static Boolean validaCPF(String CPF){
        if (CPF.equals('00000000000') || CPF.equals('11111111111') ||
            CPF.equals('22222222222') || CPF.equals('33333333333') ||
            CPF.equals('44444444444') || CPF.equals('55555555555') ||
            CPF.equals('66666666666') || CPF.equals('77777777777') ||
            CPF.equals('88888888888') || CPF.equals('99999999999') ||
            (CPF.length() != 11))
            return(false);
        
        Integer dig10, dig11, sm, i, r, num, peso;
        
        
        sm = 0;
        peso = 10;
        List<String> cpfString = cpf.split('');
        for (i=0; i<9; i++) {
            num = Integer.valueOf(cpfString[i]); 
            sm = sm + (num * peso);
            peso = peso - 1;
        }
        
        r = 11 - (math.mod(sm,11));
        if ((r == 10) || (r == 11))
            dig10 = 0;
        else dig10 = r;
        
        // Calculo do 2o. Digito Verificador
        sm = 0;
        peso = 11;
        for(i=0; i<10; i++) {
            num = Integer.valueOf(cpfString[i]);
            sm = sm + (num * peso);
            peso = peso - 1;
        }
        
        r = 11 - (math.mod(sm,11));
        if ((r == 10) || (r == 11))
            dig11 = 0;
        else dig11 = r;
        
        // Verifica se os digitos calculados conferem com os digitos informados.
        if (dig10 == Integer.valueOf(cpfString[9]) && dig11 == Integer.ValueOf(cpfString[10]))
            return true;
        else return false;
    }
   
   
    public static boolean validaCNPJ(String CNPJ) {
        // considera-se erro CNPJ's formados por uma sequencia de numeros iguais
        if (CNPJ.equals('00000000000000') || CNPJ.equals('11111111111111') ||
            CNPJ.equals('22222222222222') || CNPJ.equals('33333333333333') ||
            CNPJ.equals('44444444444444') || CNPJ.equals('55555555555555') ||
            CNPJ.equals('66666666666666') || CNPJ.equals('77777777777777') ||
            CNPJ.equals('88888888888888') || CNPJ.equals('99999999999999') ||
            (CNPJ.length() != 14))
            return false;
        
        Integer sm, i, r, num, peso, dig13, dig14;
        List<String> cnpjString = CNPJ.split('');
        sm = 0;
        peso = 2;
        for (i=11; i>=0; i--) {
            num = Integer.valueOf(cnpjString[i]);
            sm = sm + (num * peso);
            peso = peso + 1;
            if (peso == 10)
                peso = 2;
        }
        
        r = math.mod(sm, 11);
        if ((r == 0) || (r == 1))
            dig13 = 0;
        else dig13 = Integer.valueOf(11-r);
        
        // Calculo do 2o. Digito Verificador
        sm = 0;
        peso = 2;
        for (i=12; i>=0; i--) {
            num = Integer.valueOf(cnpjString[i]);
            sm = sm + (num * peso);
            peso = peso + 1;
            if (peso == 10)
                peso = 2;
        }
        
        r = math.mod(sm, 11);
        if ((r == 0) || (r == 1))
            dig14 = 0;
        else dig14 = Integer.valueOf(11-r);
        
        // Verifica se os dígitos calculados conferem com os dígitos informados.
        if (dig13 == Integer.valueOf(cnpjString[12]) && dig14 == Integer.valueOf(cnpjString[13]))
            
            return true;
        else return false ;
    }
    
    public static String imprimeCNPJ(String CNPJ) {
        return(CNPJ.substring(0, 2) + '.' + CNPJ.substring(2, 5) + '.' +
               CNPJ.substring(5, 8) + '.' + CNPJ.substring(8, 12) + '-' +
               CNPJ.substring(12, 14));
    }

}