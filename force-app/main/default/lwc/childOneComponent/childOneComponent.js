import { LightningElement, api, wire } from 'lwc';
import { subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import msgService from '@salesforce/messageChannel/test__c';

export default class ChildOneComponent extends LightningElement {
    @api valueFromParent;
    templateView;
    templateElseIf;
    dataFromJS;
    iterat = [];
    lmsData;

    constructor() {
        super();
        this.templateView = true;
        this.templateElseIf = true;
        this.dataFromJS = 'DATA FROM JS';
        this.lmsData = '';
        this.iterat.push({id: '1', text: 'firstIteratorValue'});
        this.iterat.push({id: '2', text: 'secondIteratorValue'});
        this.iterat.push({id: '3', text: 'thirdIteratorValue'});
    }

    @wire(MessageContext)
    messageContext;

    subscribeToMessageChannel() {
        this.subscription = subscribe(
            this.messageContext,
            msgService,
            (message) => this.handleMessage(message)
        );
    }

    handleMessage(message) {
        this.lmsData = message.recordData;
    }

    connectedCallback() {
        this.subscribeToMessageChannel();
    }
}