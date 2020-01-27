package Entities;

import Repository.Implementation.PostRepository;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import javax.persistence.Cacheable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;
import org.eclipse.persistence.annotations.CascadeOnDelete;
import resources.Utils;

@Entity
@Table(name = "posts")
@Cacheable(false)
@CascadeOnDelete
//@SequenceGenerator(name = "post_id_seq", sequenceName = "posts_id_seq", allocationSize = 1)
public class Post {

    @OneToMany(mappedBy = "post")
    private List<Vote> votes;

    @Id
//    @GeneratedValue(generator = "post_id_seq", strategy = GenerationType.SEQUENCE)    
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "created_by", nullable = false)
    private User createdBy;

    @ManyToOne
    private Forum forum;

    @Column(name = "title", nullable = false)
    private String title;

    @OneToOne
    private PostBody body;

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

    public int getVotes() {
        int value = 0;
        for(Vote vote : this.votes){
            value += vote.getVote();
        }
        return value;
    }

    public void setVotes(List<Vote> votes) {
        this.votes = votes;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public Forum getForum() {
        return forum;
    }

    public void setForum(Forum forum) {
        this.forum = forum;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public PostBody getBody() {
        return body;
    }

    public void setBody(PostBody body) {
        this.body = body;
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
