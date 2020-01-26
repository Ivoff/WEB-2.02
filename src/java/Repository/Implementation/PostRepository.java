package Repository.Implementation;

import Entities.Forum;
import Entities.Post;
import Repository.Repository;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class PostRepository implements Repository<Post>{

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("webapp_trabPU");
    
    @Override
    public void save(Post e) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();                
        
            if(e.getId() != 0){
                em.merge(e);
            }else{
                em.persist(e);
            }        
        em.getTransaction().commit();        
        em.close();
    }

    @Override
    public Post read(int id) {
        EntityManager em = emf.createEntityManager();        
        Post retrivedUser = em.find(Post.class, id);                        
        return retrivedUser;
    }

    @Override
    public void delete(Post e) {
        EntityManager em = emf.createEntityManager();        
        em.getTransaction().begin();
        
            if(!em.contains(e)){
                e = em.find(Post.class, e.getId());
            }
            em.remove(e);
        
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public List<Post> all() {
        EntityManager em = emf.createEntityManager();        
        Query result = em.createQuery("select u from Post u", Post.class);
        return result.getResultList();
    }
    
    public List<Post> all(String order, int max){
        EntityManager em = emf.createEntityManager();      
        Query result;
        if(order.equals("asc"))
            result = em.createQuery("select u from Post u order by u.id asc", Post.class);
        else if(order.equals("desc"))
            result = em.createQuery("select u from Post u order by u.id desc", Post.class);
        else
            result = em.createQuery("select u from Post u", Post.class);
        if(max == 0)
            return result.getResultList();
        
        return result.setMaxResults(max).getResultList();
    }
}
