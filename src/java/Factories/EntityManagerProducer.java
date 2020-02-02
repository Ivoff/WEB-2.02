package Factories;

import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.Disposes;
import javax.enterprise.inject.Produces;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class EntityManagerProducer {

    @Produces
    public EntityManagerFactory createEntityManager() {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("webapp_trabPU");
        return factory;
    }

    public void closeEntityManager(@Disposes EntityManagerFactory manager) {
        manager.close();
    }
}
