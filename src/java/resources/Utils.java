package resources;

import Entities.User;
import Repository.Implementation.UserRepository;
import java.time.Duration;

public class Utils {        

    public static String durationHumanReadable(Duration duration) {
        return duration.toString()
                .substring(2)
                .replaceAll("(\\d[HMS])(?!$)", "$1 ")
                .toLowerCase();
    }

    public static User jsonSerializer(User user) {
        UserRepository userRepo = new UserRepository();
        User newUser = new User();

        newUser.setId(user.getId());
        newUser.setName(user.getName());
        newUser.setEmail(user.getEmail());
        newUser.setBirthday(user.getBirthday());
        newUser.setCreatedAt(user.getCreatedAt());
        newUser.setUpdatedAt(user.getUpdatedAt());
        newUser.setRelations(userRepo.countRelations(user));

        return newUser;
    }

    public static String getRequestFileExtension(String fileName) {
        int i = fileName.length() - 1;
        StringBuilder extension = new StringBuilder();
        while (fileName.charAt(i) != '.') {
            extension.append(fileName.charAt(i));
            i -= 1;
        }
        extension.reverse();
        return ("." + extension.toString());
    }

}
