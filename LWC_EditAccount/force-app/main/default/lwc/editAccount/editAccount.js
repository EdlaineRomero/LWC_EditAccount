import { LightningElement, api } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import ACCOUNTNUMBER_FIELD from '@salesforce/schema/Account.AccountNumber';

export default class EditAccount extends LightningElement {
    
    // Expose a field to make it available in the template
    nameField       = NAME_FIELD;
    typeField       = TYPE_FIELD;
    numberField     = ACCOUNTNUMBER_FIELD;
    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;
   
    closeAction(){
        console.log('teste');
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    handleSuccess(event) {
        console.log(event.detail);
        this.dispatchEvent(
            new ShowToastEvent({
                message: 'Update Acccount sucess',
                label: 'Update Acccount',
                variant: 'success',
                mode: 'dismissable'
            }),
        );    
        this.closeAction(); 
    }

    handleError(event){
        console.log(event.detail);
        this.dispatchEvent(
            new ShowToastEvent({
                message: event.detail.detail,
                label: 'Update Acccount',
                variant: 'error',
                mode: 'dismissable'
            }),
        );    
    }
}