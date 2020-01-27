package Repository.Implementation;

import Entities.Post;
import Entities.PostBody;
import Repository.Repository;
import java.io.File;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class PostBodyRepository implements Repository<PostBody> {

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("webapp_trabPU");

    @Override
    public void save(PostBody e) {
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
    public PostBody read(int id) {
        EntityManager em = emf.createEntityManager();
        PostBody retrivedUser = em.find(PostBody.class, id);
        return retrivedUser;
    }

    @Override
    public void delete(PostBody e) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        if (!em.contains(e)) {
            e = em.find(PostBody.class, e.getId());
        }
        if (e.getType() == 1) {
            File image = new File(System.getenv("PROJECT_PATH") + e.getContent().replace("/WEB-2.01/", "/WEB-2.01/web/"));
            image.delete();
        }
        em.remove(e);

        em.getTransaction().commit();
        em.close();
    }

    @Override
    public List<PostBody> all() {
        EntityManager em = emf.createEntityManager();
        Query result = em.createQuery("select u from PostBody u", Post.class);
        return result.getResultList();
    }

}
