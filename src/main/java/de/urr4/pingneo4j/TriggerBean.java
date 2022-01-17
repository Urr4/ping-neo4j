package de.urr4.pingneo4j;

import org.neo4j.driver.Driver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Collections;

@Component
public class TriggerBean {

    @Autowired
    private Driver driver;

    @PostConstruct
    public void pingNeo4j(){
        driver.session().run("MATCH (n) RETURN 1", Collections.emptyMap());
        System.out.println("Done pinging Neo4j");
    }
}
