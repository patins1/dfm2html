package dfm2html.report;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;

public class Utilities {

	public static void toFile(File file, String content) throws IOException {
		BufferedWriter out = new BufferedWriter(new FileWriter(file));
		out.write(content);
		out.close();
	}

	public static void appendFile(File file, String content) throws IOException {
		BufferedWriter out = new BufferedWriter(new FileWriter(file, true));
		out.append(content);
		out.close();
	}

	/**
	 * Read the contents of a text file using a memory-mapped byte buffer.
	 * 
	 * A MappedByteBuffer, is simply a special ByteBuffer. MappedByteBuffer maps
	 * a region of a file directly in memory. Typically, that region comprises
	 * the entire file, although it could map a portion. You must, therefore,
	 * specify what part of the file to map. Moreover, as with the other Buffer
	 * objects, no constructor exists; you must ask the
	 * java.nio.channels.FileChannel for its map() method to get a
	 * MappedByteBuffer.
	 * 
	 * Direct buffers allocate their data directly in the runtime environment
	 * memory, bypassing the JVM|OS boundary, usually doubling file copy speed.
	 * However, they generally cost more to allocate.
	 */
	private static String fastStreamCopy(String filename) {
		String s = "";
		FileChannel fc = null;
		try {
			fc = new FileInputStream(filename).getChannel();

			// int length = (int)fc.size();

			MappedByteBuffer byteBuffer = fc.map(FileChannel.MapMode.READ_ONLY,
					0, fc.size());
			// CharBuffer charBuffer =
			// Charset.forName("ISO-8859-1").newDecoder().decode(byteBuffer);

			// ByteBuffer byteBuffer = ByteBuffer.allocate(length);
			// ByteBuffer byteBuffer = ByteBuffer.allocateDirect(length);
			// CharBuffer charBuffer = byteBuffer.asCharBuffer();

			// CharBuffer charBuffer =
			// ByteBuffer.allocateDirect(length).asCharBuffer();
			/*
			 * int size = charBuffer.length(); if (size > 0) { StringBuffer sb =
			 * new StringBuffer(size); for (int count=0; count<size; count++)
			 * sb.append(charBuffer.get()); s = sb.toString(); }
			 * 
			 * if (length > 0) { StringBuffer sb = new StringBuffer(length); for
			 * (int count=0; count<length; count++) {
			 * sb.append(byteBuffer.get()); } s = sb.toString(); }
			 */
			int size = byteBuffer.capacity();
			if (size > 0) {
				// Retrieve all bytes in the buffer
				byteBuffer.clear();
				byte[] bytes = new byte[size];
				byteBuffer.get(bytes, 0, bytes.length);
				s = new String(bytes);
			}

			fc.close();
		} catch (FileNotFoundException fnfx) {
			System.err.println("File not found: " + fnfx);
		} catch (IOException iox) {
			System.err.println("I/O problems: " + iox);
		} finally {
			if (fc != null) {
				try {
					fc.close();
				} catch (IOException ignore) {
					// ignore
				}
			}
		}
		return s;
	}

	public static String fromFile(File file) throws IOException {
		return fastStreamCopy(file.toString());
	}

	public static String fromFileSlow(File file) throws IOException {
		String result = "";
		BufferedReader br = new BufferedReader(new InputStreamReader(
				new FileInputStream(file)));
		String stockData;
		while ((stockData = br.readLine()) != null) {
			result += stockData;
		}
		return result;
	}

	public static String downloadURL(String s) throws MalformedURLException,
			IOException {
		try {
			URLConnection conn = new URL(s).openConnection();
			conn.setDoInput(true);
			conn.connect();
			BufferedReader br = new BufferedReader(new InputStreamReader(conn
					.getInputStream()));
			String asString = "";
			String stockData;
			while ((stockData = br.readLine()) != null) {
				asString = asString + stockData;
			}
			br.close();
			return asString;
		} catch (IOException e) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e2) {
				System.err.println("Retry downloading " + s);
				e.printStackTrace();
			}
			URLConnection conn = new URL(s).openConnection();
			conn.setDoInput(true);
			conn.connect();
			BufferedReader br = new BufferedReader(new InputStreamReader(conn
					.getInputStream()));
			String asString = "";
			String stockData;
			while ((stockData = br.readLine()) != null) {
				asString = asString + stockData + "\n";
			}
			br.close();
			return asString;
		}
	}

	static public String printPercentage(float success2) {
		return "" + Math.round(success2 * 100) + "%";
	}

}
