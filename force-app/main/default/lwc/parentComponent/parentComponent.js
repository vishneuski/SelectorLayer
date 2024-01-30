import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    dataForFirstChild;


    constructor() {
        super();
        this.dataForFirstChild = 'SOME DATA FROM PARENT';
    }

    callChildMethod() {
        this.template.querySelector("c-child-two-component").showHiddenText();
    }
}