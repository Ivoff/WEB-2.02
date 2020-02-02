package Repository.Implementation;

import Entities.Comment;
import Repository.Repository;
import java.util.List;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

@Qualifier.CommentRepository
public class CommentRepository implements Repository<Comment>{

    @Inject
    private EntityManagerFactory emf;
    
    @Override
    public void save(Comment e) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        if (e.getId() != 0) {            
            em.merge(e);
        } else {
            em.persist(e);
        }
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public Comment read(int id) {
        EntityManager em = emf.createEntityManager();
        Comment retrivedUser = em.find(Comment.class, id);
        return retrivedUser;
    }

    @Override
    public void delete(Comment e) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        
            if(!em.contains(e)){
                e = em.find(Comment.class, e.getId());
            }
            em.remove(e);
        
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public List<Comment> all() {
        EntityManager em = emf.createEntityManager();
        Query result = em.createQuery("select c from Comment c", Comment.class);        
        return result.getResultList();
    }
    
    public List<Comment> all(String options){
        EntityManager em = emf.createEntityManager();
        Query result = em.createQuery("select c from Comment c where c.parent ="+null, Comment.class);
        return result.getResultList();
    }
}

