import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

public class Unix2Apple2 {

    public static void main(String[] args) {
        try {
            Unix2Apple2 converter = new Unix2Apple2();
            for (String arg : args) {
                converter.convert(arg);
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void convert(String fileName) throws IOException {
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(fileName));
            String line;
            while ((line = reader.readLine()) != null) {
                System.out.print(line);
                System.out.print('\r');
            }
        }
        finally {
            close(reader);
        }
    }

    public void close(Reader reader) {
        if (reader != null) {
            try {
                reader.close();
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

