package de.urr4.pingneo4j;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

@SpringBootApplication
public class Application {

    //Start Application, wait 10sek for Beans to do their work and then kill application again
    public static void main(String[] args) throws InterruptedException {
        ConfigurableApplicationContext applicationContext = SpringApplication.run(Application.class, args);
        Thread.sleep(10000);
        SpringApplication.exit(applicationContext);
    }

}
