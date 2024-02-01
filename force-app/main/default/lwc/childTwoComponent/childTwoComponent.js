import { LightningElement, api, wire } from 'lwc';
import {publish,subscribe,unsubscribe,APPLICATION_SCOPE,MessageContext} from 'lightning/messageService';
import msgService from '@salesforce/messageChannel/test__c';

export default class ChildTwoComponent extends LightningElement {

    @wire(MessageContext)
    messageContext

    dataFromJS = {};
    loopData = [];
    showHidden;
    inputValue;
    
    constructor() {
        super();
        this.dataFromJS.firstName = 'Sergey';
        this.dataFromJS.text = 'GETTER DATA FROM JS';
        this.showHidden = false;
        this.inputValue = '';
        this.loopData.push({id: '1', text: '1-LoopItem'});
        this.loopData.push({id: '2', text: '2-LoopItem'});
        this.loopData.push({id: '3', text: '3-LoopItem'});
    }

    renderedCallback() {
        console.log('!!!INPUT SEARCH -' ,this.querySelector("input"));
    }

    get templateView() {
        return this.dataFromJS.firstName == 'Sergey';
    }

    @api
    showHiddenText() {
        this.showHidden = true;
    }

    handleSlotChange(e) {
        console.log('!!!OnSlotChange');
    }

    handleChangeText(e) {
        this.inputValue = e.target.value;
    }

    dispatchTextValue() {
        const payload = {
            detail: {
                text: this.inputValue,
                number: 1
            }
        };
        this.dispatchEvent(new CustomEvent("dispatchtext", {detail: payload}));
    }

    publishData() {
        const payload2 = {
            recordData: 'Hello from LMS!!!'
        };

        publish(this.messageContext, msgService, payload2);
    }
}