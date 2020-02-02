package Entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import javax.persistence.Cacheable;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import org.eclipse.persistence.annotations.CascadeOnDelete;
import org.mindrot.jbcrypt.BCrypt;

@Entity
@Table(name = "users")
@CascadeOnDelete
@Cacheable(false)
//@SequenceGenerator(name = "user_id_seq", sequenceName = "users_id_seq", allocationSize = 1)
public class User {

    @OneToMany(mappedBy = "user")
    private List<Comment> comments;

    @Id
//    @GeneratedValue(generator = "user_id_seq", strategy = GenerationType.SEQUENCE)    
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name", unique = true, nullable = false)
    private String name;

    @Column(name = "email", unique = true, nullable = false)
    private String email;

    @Column(name = "hash_pass", nullable = false)
    private String hashPass;

    @Column(name = "created_at", insertable = false, updatable = false, columnDefinition = "TIMESTAMP WITH TIME ZONE default now()")
    private LocalDateTime createdAt;

    @Column(name = "updated_at", insertable = false, columnDefinition = "TIMESTAMP WITH TIME ZONE default now()")
    private LocalDateTime updatedAt;

    @Temporal(TemporalType.DATE)
    @Column(name = "birthday", nullable = false)
    private Date birthday;

    @OneToMany(mappedBy = "createdBy", targetEntity = Forum.class, cascade = CascadeType.ALL)
    private List<Forum> forums;

    @OneToMany(mappedBy = "createdBy", targetEntity = Post.class, cascade = CascadeType.ALL)
    private List<Post> posts;

    @OneToMany(mappedBy = "user")
    private List<Vote> votes;

    @Transient
    private HashMap<String, Integer> relations;

    public HashMap<String, Integer> getRelations() {
        return relations;
    }

    public List<Vote> getVotes() {
        return votes;
    }

    public void setVotes(List<Vote> votes) {
        this.votes = votes;
    }

    public void setRelations(HashMap<String, Integer> relations) {
        this.relations = relations;
    }

    public List<Forum> getForums() {
        return forums;
    }

    public void setForums(List<Forum> forums) {
        this.forums = forums;
    }

    public List<Post> getPosts() {
        return posts;
    }

    public void setPosts(List<Post> posts) {
        this.posts = posts;
    }

    public void addForum(Forum forum) {
        this.forums.add(forum);
        forum.setCreatedBy(this);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHashPass() {
        return hashPass;
    }

    public void setHashPass(String hashPass) {
        this.hashPass = BCrypt.hashpw(hashPass, BCrypt.gensalt());
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    @Override
    public String toString() {
        return "User{" + "id=" + id + ", name=" + name + ", email=" + email + ", hashPass=" + hashPass + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", birthday=" + birthday + ", forums=" + forums + '}';
    }
}
