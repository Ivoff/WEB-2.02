package Entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import org.eclipse.persistence.annotations.CascadeOnDelete;

@Entity
@Table(name = "posts_body")
@CascadeOnDelete
//@SequenceGenerator(name = "post_body_id_seq", sequenceName = "posts_body_id_seq", allocationSize = 1)
public class PostBody {

    @OneToOne(mappedBy = "body", targetEntity = Post.class, cascade = CascadeType.PERSIST)
    private Post post;

    @Id
//    @GeneratedValue(generator = "post_body_id_seq", strategy = GenerationType.SEQUENCE)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "type", nullable = false)
    private int type;

    @Column(name = "content", nullable = false, columnDefinition = "TEXT")
    private String content;

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

}
