package board.gui;

import java.awt.Dimension;

import javax.swing.JButton;
import javax.swing.JOptionPane;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

import board.model.Notice;
import board.model.NoticeDAO;

public class BoardContent extends Page{
	JTextField t_title, t_author;
	JTextArea area;
	JScrollPane scroll;
	JButton bt_list, bt_edit, bt_del; 
	Notice notice;
	NoticeDAO noticeDAO;
	public BoardContent(BoardMain boardMain) {
		super(boardMain);
		//생성
		t_author = new JTextField();
		t_title = new JTextField();
		area = new JTextArea();
		scroll = new JScrollPane(area);
		bt_list = new JButton("목록으로");
		bt_edit = new JButton("수정하기");
		bt_del = new JButton("삭제하기");
		noticeDAO = new NoticeDAO();
		
		//스타일
		t_author.setPreferredSize(new Dimension((int)this.getPreferredSize().getWidth()-10, 25));
		t_title.setPreferredSize(new Dimension((int)this.getPreferredSize().getWidth()-10, 25));
		scroll.setPreferredSize(new Dimension((int)this.getPreferredSize().getWidth()-10, 500));
		
		//조립
		add(t_author);
		add(t_title);
		add(scroll);
		
		add(bt_list);
		add(bt_edit);
		add(bt_del);
		
		bt_list.addActionListener((e) -> {
			boardMain.showPage(Pages.valueOf("BoardList").ordinal());
		});
		
		bt_edit.addActionListener((e) -> {
			if(JOptionPane.showConfirmDialog(BoardContent.this, "수정하실래요?") == JOptionPane.OK_OPTION) {
				edit();
			}
		});
	}
	
	public void edit() {
		//DAO를 이용하여 수정작업 수행
		notice.setAuthor(t_author.getText());
		notice.setTitle(t_title.getText());
		notice.setContent(area.getText());
		int result = noticeDAO.update(notice);
		if(result == 0) {
			JOptionPane.showMessageDialog(this, "수정실패");
		} else {
			JOptionPane.showMessageDialog(this, "수정성공");
		}
	}
	
	//컴포넌트에 데이터 채워 넣기!!
	public void setData(Notice notice) {
		this.notice = notice;
		t_author.setText(notice.getAuthor());
		t_title.setText(notice.getTitle());
		area.setText(notice.getContent());
	}
}
