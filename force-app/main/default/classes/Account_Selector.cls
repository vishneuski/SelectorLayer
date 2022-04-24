public inherited sharing class Account_Selector extends fflib_SObjectSelector {
//При желании с помощью конструктора по умолчанию можно установить параметры, которые можно изменить.
    public Account_Selector(){
    /* Вызов конструктора класса fflib_SObjectSelector и установка следующих булевых значений:
    1) Если запрос должен использовать наборы полей - по умолчанию false
    2) Если хотим обеспечить безопасность CRUD - по умолчанию true
    3) Если хотим применить FLS - по умолчанию false
    4) Если хотим отсортировать выбранные поля - по умолчанию true
    */
    super(false, false, false, false);
    }

    public Account_Selector(Boolean includeFieldSetFields){
        /* Вызов конструктора класса fflib_SObjectSelector и установка следующих булевых значений:
        1) Если запрос должен использовать наборы полей
        2) Если хотим обеспечить безопасность CRUD
        3) Если хотим применить FLS
        4) Если хотим отсортировать выбранные поля
        */
        // super(true, false, false, true);
        super(includeFieldSetFields);
        }

    //Базовые поля для объекта, которые должны использоваться абсолютно в каждом запросе, выполняемом этим классом.
    public List<Schema.SObjectField> getSObjectFieldList(){
		return new List<Schema.SObjectField>{
			Account.Id,
			Account.Name,
            Account.Email__c
		};
	}

    public List<Account> selectAccountsById(Set<Id> acctIds){
        return new Account_Selector_WithoutSharing().selectAccountsByIdElevated(acctIds);
    } 

    // Внутренний приватный класс с метод игнорирующим правила совместного пользования
    private without sharing class Account_Selector_WithoutSharing{
        public List<Account> selectAccountsByIdElevated(Set<Id> acctIds){
            return [SELECT Id FROM Account WHERE Id IN : acctIds]; 
        }
    }

    public override List<Schema.FieldSet> getSObjectFieldSetList(){
        return new List<Schema.FieldSet>{SObjectType.Account.FieldSets.TestSelectorLayer};
    }

    public override String getOrderBy(){
        return 'Active__c DESC, Email__c, Name, Phone';
    }

    //
    public List<Account> selectAccounts(Set<Id> idSet){
        return (List<Account>) Database.query(newQueryFactory(false).
            assertIsAccessible().
            selectFields(new List<String>{'Active__c', 'Type', 'Phone', 'Owner.Username'}).
            setCondition('Id in: idSet').
            setOrdering(Account.Phone, fflib_QueryFactory.SortOrder.ASCENDING).
            setLimit(10000).
            toSOQL());
    }

    public List<Account> innerQueryExample(Set<Id> idSet){
        fflib_QueryFactory accountQueryFactory = newQueryFactory()
            .setCondition('Id IN :idSet');
        fflib_QueryFactory offerSubSelectQuery = new Offer_Selector().addQueryFactorySubselect(accountQueryFactory, 'Offers__r')
            .selectFields(new List<String>{'Status__c'});
        return (List<Account>) Database.query(accountQueryFactory.toSOQL());
    }

    //Получить тип для объекта, запрашиваемого этим классом.
	public Schema.SObjectType getSObjectType(){
		return Account.SObjectType;
	}
	//Позволяет создать запрос, который выбирает записи по Set<Id>(в основном запросе нужно добавить WHERE Id IN :accountIds)
	public List<Account> selectById(Set<Id> accountIds){
		return (List<Account>) selectSObjectsById(accountIds);
	}
}