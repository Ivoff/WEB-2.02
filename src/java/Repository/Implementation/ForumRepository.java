package Repository.Implementation;

import Entities.Forum;
import Entities.User;
import Repository.Repository;
import java.io.File;
import java.util.List;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class ForumRepository implements Repository<Forum> {

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("webapp_trabPU");

    @Override
    public void save(Forum e) {
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
    public Forum read(int id) {
        EntityManager em = emf.createEntityManager();
        Forum retrivedUser = em.find(Forum.class, id);
        return retrivedUser;
    }

    public Forum read(String query) {
        EntityManager em = emf.createEntityManager();

        Query result = em.createNativeQuery("select * from forums where name = '" + query + "' limit 1", Forum.class);
        try {
            Forum forum = (Forum) result.getSingleResult();
            return (Forum) result.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public void delete(Forum e) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        if (!em.contains(e)) {
            e = em.find(Forum.class, e.getId());
        }
        
        File image = new File(System.getenv("PROJECT_PATH")+e.getImagePath().replace("/WEB-2.01/", "/WEB-2.01/web/"));
        image.delete();
        em.remove(e);

        em.getTransaction().commit();
        em.close();
    }

    @Override
    public List<Forum> all() {
        EntityManager em = emf.createEntityManager();
        Query result = em.createQuery("select u from Forum u", Forum.class);
        return result.getResultList();
    }

    public List<Forum> all(String order) {
        EntityManager em = emf.createEntityManager();
        Query result = em.createNativeQuery("select * from forums order by id " + order, Forum.class);
        return result.getResultList();
    }
}
