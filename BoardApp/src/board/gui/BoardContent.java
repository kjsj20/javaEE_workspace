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
		//����
		t_author = new JTextField();
		t_title = new JTextField();
		area = new JTextArea();
		scroll = new JScrollPane(area);
		bt_list = new JButton("�������");
		bt_edit = new JButton("�����ϱ�");
		bt_del = new JButton("�����ϱ�");
		noticeDAO = new NoticeDAO();
		
		//��Ÿ��
		t_author.setPreferredSize(new Dimension((int)this.getPreferredSize().getWidth()-10, 25));
		t_title.setPreferredSize(new Dimension((int)this.getPreferredSize().getWidth()-10, 25));
		scroll.setPreferredSize(new Dimension((int)this.getPreferredSize().getWidth()-10, 500));
		
		//����
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
			if(JOptionPane.showConfirmDialog(BoardContent.this, "�����ϽǷ���?") == JOptionPane.OK_OPTION) {
				edit();
			}
		});
	}
	
	public void edit() {
		//DAO�� �̿��Ͽ� �����۾� ����
		notice.setAuthor(t_author.getText());
		notice.setTitle(t_title.getText());
		notice.setContent(area.getText());
		int result = noticeDAO.update(notice);
		if(result == 0) {
			JOptionPane.showMessageDialog(this, "��������");
		} else {
			JOptionPane.showMessageDialog(this, "��������");
		}
	}
	
	//������Ʈ�� ������ ä�� �ֱ�!!
	public void setData(Notice notice) {
		this.notice = notice;
		t_author.setText(notice.getAuthor());
		t_title.setText(notice.getTitle());
		area.setText(notice.getContent());
	}
}
