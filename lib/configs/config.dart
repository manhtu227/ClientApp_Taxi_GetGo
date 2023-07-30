import 'package:intl/intl.dart';

class Config {
  static String formatCurrency(double amount) {
    // Định dạng số theo đơn vị tiền tệ của Việt Nam (VNĐ)
    final currencyFormat = NumberFormat("#,###", "vi_VN");
    // Chuyển đổi số sang chuỗi định dạng tiền tệ và thêm ký tự "đ" vào cuối
    return currencyFormat.format(amount) + " ₫";
  }
}
