public inherited sharing class Offer_Selector extends fflib_SObjectSelector {
    //При желании с помощью конструктора по умолчанию можно установить параметры, которые можно изменить.
        public Offer_Selector(){
        /* Вызов конструктора класса fflib_SObjectSelector и установка следующих булевых значений:
        1) Если запрос должен использовать наборы полей
        2) Если хотим обеспечить безопасность CRUD
        3) Если хотим применить FLS
        4) Если хотим отсортировать выбранные поля
        */
        super(false, true, true, true);
        }
    
        //Базовые поля для объекта, которые должны использоваться абсолютно в каждом запросе, выполняемом этим классом.
        public List<Schema.SObjectField> getSObjectFieldList(){
            return new List<Schema.SObjectField>{
                Offer__c.Id,
                Offer__c.Name
            };
        }

        //Получить тип для объекта, запрашиваемого этим классом.
        public Schema.SObjectType getSObjectType(){
            return Offer__c.SObjectType;
        }

       

        //Позволяет создать запрос, который выбирает записи по Set<Id>(в основном запросе нужно добавить WHERE Id IN :accountIds)
        public List<Offer__c> selectById(Set<Id> offerIds){
            return (List<Offer__c>) selectSObjectsById(offerIds);
        }
    }