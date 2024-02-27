import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    dataForFirstChild;
    valueFromChild;


    constructor() {
        super();
        this.valueFromChild = '';
        this.dataForFirstChild = 'SOME DATA FROM PARENT';
    }

    callChildMethod() {
        this.template.querySelector("c-child-two-component").showHiddenText();
    }

    handleDispatchText(e) {
        this.valueFromChild = e.detail.detail.text;
    }

    changeDataForChild() {
        this.dataForFirstChild = 'CHANGED DATA FOR CHILD';
    }
}