public with sharing class CountryPhoneCode {

    public static String getPhonePrefix(String phone) {
        List<String> phonePatterns = new List<String>{
                '^(\\+375)[\\-]?[0-9]{2}[\\-]?[0-9]{7}', '^(\\+7)[\\-]?[0-9]{3}[\\-]?[0-9]{7}', '^(\\+48)[\\-]?[0-9]{2}[\\-]?[0-9]{7}'
        };
        for (String phPattern : phonePatterns) {
            Pattern phonePattern = Pattern.compile(phPattern);
            Matcher phoneMatcher = phonePattern.matcher(phone);
            if (phoneMatcher.matches()) {
                return phone.substringBetween('+', '-');
            }
        }
        return null;
    }
}