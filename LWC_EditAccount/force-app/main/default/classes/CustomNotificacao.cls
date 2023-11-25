/************************
* Classe CustomNotificacao
* Create Edlaine Garcia Magalhães (edlaineromero@gmail.com)
* 
* Classe de teste : AccountController_tst 
* 
* @Version					Date				User				Info
* 	1.0						2023-11-23			Edlaine Garcia		Create Trigger	
*/
public class CustomNotificacao {
    
    public static void userNotification(String errorTitle, String message, String id) {
        
        CustomNotificationType notificationType = [
            SELECT Id, DeveloperName 
            FROM CustomNotificationType 
            WHERE DeveloperName='Custom_Notification'
        ];
        
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        
        Set<String> setUsers = new Set<String>();					
        setUsers.add(UserInfo.getUserId());	
        
        notification.setTitle(errorTitle);
        notification.setBody(message);
        
        notification.setNotificationTypeId(notificationType.Id);
        notification.setTargetId(id);
        
        try {
            notification.send(setUsers);
        }
        catch (Exception e) {
            System.debug('Ocorreu um erro ao enviar a notificação: ' + e.getMessage());
        }
    }
}