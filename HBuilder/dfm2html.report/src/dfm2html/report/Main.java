package dfm2html.report;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class Main {

	/**
	 * @param args
	 * @throws IOException
	 */
	public static void main(String[] args) throws IOException {
		SearchStructure sea = new SearchStructure(Utilities.fromFile(new File("C:/repositories/logs/t.txt")));
		Map<String, Integer> versionToUsers = new HashMap<String, Integer>();
		String sDate;
		String sVersion;
		String sDays;
		int users = 0;
		int allDays = 0;
		while ((sDate = sea.findNext("GET /autoupd/", "/")) != null && (sVersion = sea.findNext("DFM2HTML_", "/")) != null && (sDays = sea.findNext("", " ")) != null) {
			int days = Integer.parseInt(sDays);
			if (days >= 0 && days <= 30) {
				Integer usersOfVersion = versionToUsers.get(sVersion);
				if (usersOfVersion == null) {
					usersOfVersion = new Integer(0);
				}
				usersOfVersion++;
				versionToUsers.put(sVersion, usersOfVersion);

				users++;

				allDays += days;
			}
		}
		System.out.println("startAfter = " + (allDays / users));
		System.out.println("users = " + users);
		for (String ver : versionToUsers.keySet()) {
			System.out.println("users of " + ver + " = " + versionToUsers.get(ver));
		}
	}

}
