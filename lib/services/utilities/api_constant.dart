String kBaseUrl = "https://alinea-api.my.id/api";

class APIEndpoint {
  static String login = "/login";
  static String books = "/books";
  static String categories = "/categories";
  static String addcart = "/carts/addCart/{bookId}";
  static String carts = "/carts/mycart";
  static String me = "/me";
  static String deleteCart = "/carts/{cartId}";
  static String checkOut = "/borrowings";
  static String borrowingsHistory = "/borrowings/history";
  static String register = "/register";
  static String invoice = "/invoices/myinvoice";
  static String detailInvoice = "/invoices";
  static String pdfInvoice = "/invoices/download";
  static String updateProfile = "/profile/update";
  static String myNotification = "/notifications/mynotif";
  static String myDenda = "/invoices/myinvoice/fined";
}
