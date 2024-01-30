import { LightningElement, api } from 'lwc';

export default class ChildTwoComponent extends LightningElement {
    dataFromJS = {};
    loopData = [];
    showHidden;
    
    constructor() {
        super();
        this.dataFromJS.firstName = 'Sergey';
        this.dataFromJS.text = 'GETTER DATA FROM JS';
        this.showHidden = false;
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
}