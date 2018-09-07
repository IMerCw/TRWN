package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.consumer.CONSUMER_NoticeDTO;
import poly.dto.consumer.CONSUMER_UserDTO;
import poly.persistance.mapper.CONSUMER_NoticeMapper;
import poly.service.CONSUMER_INoticeService;

@Service("CONSUMER_NoticeService")
public class CONSUMER_NoticeService implements CONSUMER_INoticeService {

   @Resource(name = "CONSUMER_NoticeMapper")
   private CONSUMER_NoticeMapper noticeMapper;

}