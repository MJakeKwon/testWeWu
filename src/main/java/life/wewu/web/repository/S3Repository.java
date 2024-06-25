package life.wewu.web.repository;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface S3Repository {

	//�޼ҵ�
	//���� ���ε�(���̹� ���丮��)
	//dddd
	public String uplodaFile(Map<String, Object> map);
	
	//short url ���
	public String getShortUrl(String url);
	
}
