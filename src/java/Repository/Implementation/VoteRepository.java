package Repository.Implementation;

import Entities.Vote;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class VoteRepository {

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("webapp_trabPU");

    public void vote(Vote v) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        Query alreadyVoted = em.createQuery("select v from Vote v where v.post.id = " + v.getPost().getId() + " and v.user.id = " + v.getUser().getId());

            if (alreadyVoted.getResultList().isEmpty()) {
                em.persist(v);
            } else {
                if (!em.contains(v)) {
                    v = (Vote) alreadyVoted.getSingleResult();
                }
                em.remove(v);
            }

        em.getTransaction().commit();
        em.close();
    }

}
