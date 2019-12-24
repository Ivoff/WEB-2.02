package Repository;

import java.util.List;

public interface Repository<T> {
    public void save(T e);
    public T read(int id);    
    public void delete(T e);
    public List<T> all();
}
