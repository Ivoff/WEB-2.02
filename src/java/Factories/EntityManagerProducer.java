package Factories;

import javax.enterprise.context.RequestScoped;
import javax.enterprise.inject.Disposes;
import javax.enterprise.inject.Produces;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class EntityManagerProducer {
    private static EntityManagerFactory factory = Persistence.createEntityManagerFactory("webapp_trabPU");
    
    @Produces @RequestScoped
    public EntityManager createEntityManager(){
        return factory.createEntityManager();
    }
    
    public void closeEntityManager(@Disposes EntityManager manager){
        manager.close();
    }
}
