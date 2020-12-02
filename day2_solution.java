import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class day2_solution {
    public static void main(String[] args) throws FileNotFoundException {
    //Load password policy file
    File passwordList = new File("day2_given-password_list.txt");  
    Scanner sc = new Scanner(passwordList);

    int compliantPasswordCount = 0, compliantPasswordCountV2 = 0;
    //Grab line from file
    while(sc.hasNextLine()) {
        String line = sc.nextLine();
        //Split line into password policy and password
        //ex: "0-3 a: abcdefgh" --> ["1-3 a", "abcdefgh"]
        String[] processedLine = line.split(": ");
        //ex: "abcdefgh"
        String password = processedLine[1];
        //ex: "1-3 a" --> ["1","3 a"]
        String[] passwordPolicy = processedLine[0].split("-");
        //ex: ["1","3 a"] --> "1"
        int minChars = Integer.parseInt(passwordPolicy[0]);
        //ex: "3 a" --> ["3", "a"]
        String[] passwordReqChar = passwordPolicy[1].split(" ");
        //ex: ["3", "a"] --> "3" --> 3
        int maxChars = Integer.parseInt(passwordReqChar[0]);
        //ex: ["3", "a"] --> "a" --> 'a'
        char reqChar = passwordReqChar[1].charAt(0);

        //Count number of reqChar occurrences
        int reqCharCount = 0;
        for(int i = 0; i < password.length(); i++) {
        if(password.charAt(i) == reqChar) reqCharCount++;
        }
        //Count number of compliant passwords
        if(reqCharCount >= minChars && reqCharCount <= maxChars) compliantPasswordCount++;
        //There's been a policy update. check for chars and XOR result
        //minChars=firstPotentialOccurrence and maxChars=secondPotentialOccurrence
        if(password.charAt(minChars-1) == reqChar ^ password.charAt(maxChars-1) == reqChar) compliantPasswordCountV2++;
    }
    System.out.println("Puzzle 1: There were " + compliantPasswordCount + " compliant passwords found.");
    System.out.println("Puzzle 2: There were " + compliantPasswordCountV2 + " compliant passwords found.");
    }
}
