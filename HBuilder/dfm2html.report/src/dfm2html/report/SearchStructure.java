package dfm2html.report;

public class SearchStructure {

	private final String string;

	int index = 0;

	public SearchStructure(String string) {
		this.string = string;
	}

	public String findNext(String startsWith, String endsWith) {
		int i = index;
		if (i == -1)
			throw new RuntimeException(
					"Already failed findNext cannot be resumed!");
		i = string.indexOf(startsWith, i);
		if (i == -1) {
			return null;
		}
		i += startsWith.length();
		int beginIndex = i;
		i = string.indexOf(endsWith, i);
		if (i == -1) {
			return null;
		}
		String result = string.substring(beginIndex, i);
		i += endsWith.length();
		index = i;
		return result;
	}

	static public String find(String string, String startsWith, String endsWith) {
		return new SearchStructure(string).findNext(startsWith, endsWith);
	}

}
