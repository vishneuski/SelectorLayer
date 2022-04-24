@IsTest
private class CountryPhoneCodeTest {
    @IsTest
    static void correctPhoneTest() {
        String correctPhone = '+375-29-2819967';
        String expectedResult = '375';
        String actualResult = CountryPhoneCode.getPhonePrefix(correctPhone);
        System.assertEquals(expectedResult, actualResult);
    }

    @IsTest
    static void invalidPhoneTest() {
        String wrongPhone = '+qwe-qeqweqwe';
        String expectedResult = null;
        String actualResult = CountryPhoneCode.getPhonePrefix(wrongPhone);
        System.assertEquals(expectedResult, actualResult);
    }
}