import { LightningElement } from 'lwc';

export default class TestComponent extends LightningElement {

    fullName = { firstName : '', lastName : '' };

    connectedCallback() {
        this.fullName = { firstName : 'John', lastName : 'Doe' };
        this.run();
    }

    run() {
        this.fullName.firstName = 'Siarhei';
    }

}