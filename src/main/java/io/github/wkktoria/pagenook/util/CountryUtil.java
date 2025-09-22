package io.github.wkktoria.pagenook.util;

import jakarta.servlet.http.HttpServletRequest;

import java.net.http.HttpRequest;
import java.util.Locale;
import java.util.Map;
import java.util.TreeMap;

public class CountryUtil {

    public static void generateCountryList(HttpServletRequest request) {
        String[] countryCodes = Locale.getISOCountries();
        Map<String, String> mapCountries = new TreeMap<>();

        for (String countryCode : countryCodes) {
            Locale locale = Locale.forLanguageTag("und-" + countryCode);
            String code = locale.getCountry();
            String name = locale.getDisplayCountry();
            mapCountries.put(name, code);
        }

        request.setAttribute("mapCountries", mapCountries);
    }

}
