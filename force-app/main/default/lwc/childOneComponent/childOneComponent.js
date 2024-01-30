import { LightningElement, api } from 'lwc';

export default class ChildOneComponent extends LightningElement {
    @api valueFromParent;
    templateView;
    templateElseIf;
    dataFromJS;
    iterat = [];


    constructor() {
        super();
        this.templateView = true;
        this.templateElseIf = true;
        this.dataFromJS = 'DATA FROM JS';
        this.iterat.push({id: '1', text: 'firstIteratorValue'});
        this.iterat.push({id: '2', text: 'secondIteratorValue'});
        this.iterat.push({id: '3', text: 'thirdIteratorValue'});
    }

    connectedCallback() {
        console.log('THIS.iterator', this.iterat);
    }

}