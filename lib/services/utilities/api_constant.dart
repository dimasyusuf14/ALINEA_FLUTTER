String kBaseUrl = "https://alinea-api.my.id/api";
// String kBaseUrl = "http://192.168.1.5:8000/api";

class APIEndpoint {
  static String login = "/login";
  static String books = "/books";
  static String categories = "/categories";
  static String addcart = "/addcart/{bookId}";
  static String carts = "/carts/mycart";
  static String me = "/me";
  static String deleteCart = "/carts/{cartId}";
}
