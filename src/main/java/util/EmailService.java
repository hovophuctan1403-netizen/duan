package util;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {
    public static final String ADMIN_EMAIL = "hovophuctan1403@gmail.com";
    private static final String SENDER_EMAIL = "hovophuctan1403@gmail.com";
    
    // DÁN MẬT KHẨU 16 KÝ TỰ CỦA BẠN VÀO ĐÂY:
    private static final String APP_PASSWORD = "zwqf psta ibvd dbvj"; 

    public static boolean sendOtp(String toEmail, String otp) {
        System.out.println("==================================================");
        System.out.println(">>> Đang gửi OTP đến hòm thư: " + toEmail);
        System.out.println(">>> MÃ OTP TẠO RA: " + otp);
        System.out.println("==================================================");

        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, APP_PASSWORD.replace(" ", "").trim());
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "Task Manager"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã OTP Đặt Lại Mật Khẩu Quản Lý");
            message.setText("Xin chào Quản Lý,\n\n"
                          + "Mã OTP xác nhận đặt lại mật khẩu là: " + otp + "\n\n"
                          + "Mã có hiệu lực trong 5 phút. Vui lòng không chia sẻ cho ai khác.");

            Transport.send(message);
            System.out.println(">>> [THÀNH CÔNG] Đã gửi mã OTP thực tế vào Gmail!");
            return true;
        } catch (Exception e) {
            System.err.println(">>> [LỖI GỬI GMAIL SMTP]: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}