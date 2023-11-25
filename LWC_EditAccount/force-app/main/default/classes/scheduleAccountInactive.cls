/************************
* Classe scheduleAccountInactive
* Create Edlaine Garcia Magalhães (edlaineromero@gmail.com)
* 
* Classe de teste : scheduleAccountInactive_tst 
* 
* @Version					Date				User				Info
* 	1.0						2023-11-23			Edlaine Garcia		Create class	
*/
global class scheduleAccountInactive implements Schedulable {
   global void execute(SchedulableContext sc) {
      CleanAccountInactive b = new CleanAccountInactive(); 
      Database.executeBatch(b);
   }
}