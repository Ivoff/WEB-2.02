package Repository.Implementation;

import Entities.Forum;
import Repository.Repository;
import java.util.List;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.Query;

public class ForumRepository implements Repository<Forum>{
    @Inject private EntityManager em;
    
    @Override
    public void save(Forum e) {
        em.getTransaction().begin();
        
            if(e.getId() != 0){
                em.merge(e);
            }else{
                em.persist(e);
            }        
        em.getTransaction().commit();        
    }

    @Override
    public Forum read(int id) {
        Forum retrivedUser = em.find(Forum.class, id);                        
        return retrivedUser;
    }

    @Override
    public void delete(Forum e) {
        em.getTransaction().begin();
        
            if(!em.contains(e)){
                e = em.find(Forum.class, e.getId());
            }
            em.remove(e);
        
        em.getTransaction().commit();
    }

    @Override
    public List<Forum> all() {
        Query result = em.createQuery("select u from User u", Forum.class);
        return result.getResultList();
    }    
}
