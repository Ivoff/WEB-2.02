package Entities;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import javax.persistence.Cacheable;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import resources.Utils;

@Entity
@Table(name = "comments")
@Cacheable(false)
public class Comment {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
        
    @ManyToOne
    private User user;
        
    @ManyToOne
    private Post post;
    
    private String body;
    
    @ManyToOne
    private Comment parent;
//    cascade = CascadeType.ALL
    @OneToMany(mappedBy = "parent")
    private List<Comment> children;
    
    @Column(name = "created_at", insertable = false, updatable = false, columnDefinition = "TIMESTAMP WITH TIME ZONE default now()")
    private LocalDateTime createdAt;

    @Column(name = "updated_at", insertable = false, columnDefinition = "TIMESTAMP WITH TIME ZONE default now()")
    private LocalDateTime updatedAt;
    
    @Transient
    private String duration;

    public String getDuration() {
        Duration difference = Duration.between(this.createdAt, LocalDateTime.now());
        String aux = Utils.durationHumanReadable(difference);
        int dotIndex = aux.indexOf('.');
        return aux.substring(0, dotIndex).concat("s");
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public Comment getParent() {
        return parent;
    }

    public void setParent(Comment parent) {
        this.parent = parent;
    }

    public List<Comment> getChildren() {
        return children;
    }

    public void setChildren(List<Comment> children) {
        this.children = children;
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
    
    
}
