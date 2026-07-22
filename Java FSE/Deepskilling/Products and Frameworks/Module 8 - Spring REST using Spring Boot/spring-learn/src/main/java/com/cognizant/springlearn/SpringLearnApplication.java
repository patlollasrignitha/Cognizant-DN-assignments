package com.cognizant.springlearn;

import org.slf4j.Logger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

@SpringBootApplication
public class SpringLearnApplication {

    private static final Logger LOGGER =
            LoggerFactory.getLogger(SpringLearnApplication.class);

    public static void main(String[] args) {

        SpringApplication.run(SpringLearnApplication.class, args);

        SpringLearnApplication app =
                new SpringLearnApplication();

        app.displayCountries();
    }

    public void displayCountries() {

        LOGGER.info("START");

        ApplicationContext context =
                new ClassPathXmlApplicationContext("country.xml");

        ArrayList<Country> countryList =
                context.getBean("countryList", ArrayList.class);

        LOGGER.debug("Countries : {}", countryList);

        LOGGER.info("END");
    }
    public void displayDate() {

        LOGGER.info("START");

        try {

            ApplicationContext context =
                    new ClassPathXmlApplicationContext("date-format.xml");

            SimpleDateFormat format =
                    context.getBean("dateFormat", SimpleDateFormat.class);

            Date date = format.parse("31/12/2018");

            LOGGER.debug("Date : {}", date);

        } catch (Exception e) {

            LOGGER.error("Exception occurred", e);

        }

        LOGGER.info("END");
    }
}