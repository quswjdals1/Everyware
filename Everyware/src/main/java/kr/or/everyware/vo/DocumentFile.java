package kr.or.everyware.vo;

import lombok.Data;

@Data
public class DocumentFile {
	private int fileId;
	private int docSn;
	private String atchFilePath;
	private String atchFileNM;
}
