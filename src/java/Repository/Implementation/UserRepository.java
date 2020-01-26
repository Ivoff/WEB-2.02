/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Repository.Implementation;

import Entities.Forum;
import Entities.Post;
import Entities.User;
import Repository.Repository;
import com.google.gson.Gson;
import java.util.HashMap;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.Persistence;
import javax.persistence.Query;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author zilas
 */
public class UserRepository implements Repository<User>{

    EntityManagerFactory emf = Persistence.createEntityManagerFactory("webapp_trabPU");
    
    @Override
    public void save(User e) {
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
    public User read(int id) {
        EntityManager em = emf.createEntityManager();                
        User retrivedUser = em.find(User.class, id);                        
        return retrivedUser;
    }
    
    public User read(String query){
        EntityManager em = emf. createEntityManager();
        
        if(query.indexOf('@') == -1){
            Query result = em.createNativeQuery("select * from users where name = '"+query+"' limit 1", User.class);
            try{                
                return (User) result.getSingleResult();
            }catch(NoResultException e){
                return null;
            }
        }
        
        Query result = em.createNativeQuery("select * from users where email = '"+query+"' limit 1", User.class);        
        try{
            User user = (User) result.getSingleResult();
            return (User) result.getSingleResult();
        }catch(NoResultException e){
            return null;
        } 
    }

    @Override
    public void delete(User e) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        
            if(!em.contains(e)){
                e = em.find(User.class, e.getId());
            }
            em.remove(e);
        
        em.getTransaction().commit();
        em.close();
    }

    @Override
    public List<User> all() {
        EntityManager em = emf.createEntityManager();
        Query result = em.createQuery("select u from User u", User.class);        
        return result.getResultList();
    }
    
    public boolean testUser(String email, String rawpass){        
        User retrievedUser = read(email);
        if(retrievedUser != null){
            return BCrypt.checkpw(rawpass, retrievedUser.getHashPass());
        }
        return false;
    }        
    
    public List<User> search(String query){
        EntityManager em = emf.createEntityManager();
        StringBuilder sb = new StringBuilder(query);
        sb.deleteCharAt(0);
        String query2 = sb.toString();
        Query result = em.createNativeQuery("select * from users where name like '%"+query+"%' or name like '_"+query2+"%'", User.class);
        return result.getResultList();
    }
    
    public HashMap<String, Integer> countRelations(User user){
        EntityManager em = emf.createEntityManager();
        Query resultForum = em.createQuery("select f from Forum f, User u where u.id = "+user.getId()+" and f.createdBy = u");                
        Query resultPost = em.createQuery("select p from Post p, User u where u.id = "+user.getId()+" and p.createdBy = u");                
        
        HashMap<String, Integer> relations = new HashMap<>();       
        relations.put("forums", resultForum.getResultList().size());
        relations.put("posts", resultPost.getResultList().size());
        
        return relations;
    }
}
