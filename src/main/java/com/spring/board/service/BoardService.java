package com.spring.board.service;

import lombok.AllArgsConstructor;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.spring.board.model.BoardDto;
import com.spring.board.model.BoardEntity;
import com.spring.board.model.ReplyDto;
import com.spring.board.model.ReplyEntity;
import com.spring.board.repository.BoardRepository;
import com.spring.board.repository.BoardRepositorySupport;
import com.spring.board.repository.ReplyRepository;
import com.spring.common.model.PageVO;
import com.spring.security.model.UserEntity;

import javax.transaction.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@AllArgsConstructor
@Service
public class BoardService {
    private BoardRepository boardRepository;
    private ReplyRepository replyRepository;
    private BoardRepositorySupport boardRepositorySupport;
    
    //@Cacheable(key = "#pageNum", value = "getBoardList")
    @Transactional
    public List<BoardDto> getBoards(PageVO pageVO, String keyword) {
    	Page<BoardEntity> page = boardRepository.findByTitleContaining(PageRequest.of(pageVO.getPage(), pageVO.getPerPage(), Sort.by(Direction.ASC, "createdDate")), keyword);
        List<BoardEntity> boardEntities = page.getContent();
        List<BoardDto> boardDtoList = new ArrayList<>();
        
        for ( BoardEntity boardEntity : boardEntities) {
        	boardDtoList.add(this.convertEntityToDto(boardEntity));
        }
        
        return boardDtoList;
    }
    
    @Transactional
    public Long getBoardCount(String keyword) {
    	if(keyword == null) {
    		return boardRepository.count();
    	}
        return boardRepository.countByTitleContaining(keyword);
    }
    
    @Transactional
    public BoardDto getBoard(Long id) {
        Optional<BoardEntity> entityWrapper = boardRepository.findById(id);
        BoardDto boardDto = new BoardDto();
        if(entityWrapper.isPresent()) {
        	BoardEntity boardEntity = entityWrapper.get();
        	boardDto = convertEntityToDto(boardEntity);
        }
        
        return boardDto;
    }
    
    @Transactional
	public List<ReplyDto> getReplys(Long no) {
    	List<ReplyEntity> replyEntityList = replyRepository.findByBoardId(no);
    	List<ReplyDto> replyDtoList = new ArrayList<>();
    	replyEntityList.forEach(entity -> {
    		replyDtoList.add(convertEntityToDto(entity));
    	});
		return replyDtoList;
	}
	
    @Transactional
    public Long addBoard(BoardDto boardDto) {
    	BoardEntity entity = boardDto.toEntity();
        return boardRepository.save(entity).getId();
    }

    @Transactional
	public Long addReply(ReplyDto replyDto) {
    	ReplyEntity entity = replyDto.toEntity();
    	entity.setBoard(BoardEntity.builder().id(replyDto.getBoardId()).build());
        return replyRepository.save(entity).getId();
	}
	
    @Transactional
    public void deleteBoard(Long id) {
        boardRepository.deleteById(id);
    }
    
    private BoardDto convertEntityToDto(BoardEntity boardEntity) {
        return BoardDto.builder()
                .id(boardEntity.getId())
                .title(boardEntity.getTitle())
                .content(boardEntity.getContent())
                .registrant(boardEntity.getRegistrant().getEmail())
                .createdDate(boardEntity.getCreatedDate())
                .build();
    }
    
    private ReplyDto convertEntityToDto(ReplyEntity replyEntity) {
    	return ReplyDto.builder()
    			.id(replyEntity.getId())
    			.boardId(replyEntity.getBoard().getId())
    			.registrant(replyEntity.getRegistrant().getEmail())
    			.content(replyEntity.getContent())
    			.createdDate(replyEntity.getCreatedDate())
    			.build();
    }

    /*
    public Integer[] getPageList(Integer curPageNum, String keyword) {
        Integer[] pageList = new Integer[BLOCK_PAGE_NUM_COUNT];

        // ??? ????????? ??????
        Double postsTotalCount = Double.valueOf(this.getBoardCount(keyword));

        // ??? ????????? ???????????? ????????? ????????? ????????? ?????? ?????? (???????????? ??????)
        Integer totalLastPageNum = (int)(Math.ceil((postsTotalCount/PAGE_POST_COUNT)));

        // ?????? ???????????? ???????????? ????????? ????????? ????????? ?????? ??????
        Integer blockLastPageNum = (totalLastPageNum > curPageNum + BLOCK_PAGE_NUM_COUNT)
                ? curPageNum + BLOCK_PAGE_NUM_COUNT
                : totalLastPageNum;

        // ????????? ?????? ?????? ??????
        curPageNum = (curPageNum <= 3) ? 1 : curPageNum - 2;

        int val = curPageNum;
        int idx = 0;
        while (pageList[BLOCK_PAGE_NUM_COUNT-1]==null) {
        	if(val > totalLastPageNum) {
        		break;
        	}
			pageList[idx++] = val++;
		}
        return pageList;
    }
	*/
}
