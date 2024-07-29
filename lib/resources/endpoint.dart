// ignore_for_file: constant_identifier_names

class Endpoint {
  // Auth
  static const auth_login = 'api/login';
  static const auth_register = 'api/register';
  static const auth_logout = 'api/logout';

  // User
  static const api_users = 'api/api-users';
  static const api_users_id = 'api/api-users/';

  // Category
  static const api_categories = 'api/api-categories';
  static const api_categories_id = 'api/api-categories/';

  // Menu
  static const api_menus = 'api/api-menus';
  static const api_menus_id = 'api/api-menus/';
  static const api_menus_search = 'api/api-menus-search?query=';
  static const api_menus_category = 'api/api-menus-category/';

  // Order
  static const api_orders = 'api/api-orders';
  static const api_orders_time = 'api/api-orders/';
  static const api_orders_id = 'api/api-orders/';

  // OrderItem
  static const api_order_item = 'api/api-order-item';
  static const api_order_item_id = 'api/api-order-item/';
  static const api_order_item_by_order_id = 'api/api-order-item-by-order/';

  // Report
  static const api_reports = 'api/api-reports';
  static const api_reports_id = 'api/api-reports/';
  static const api_reports_time = 'api/api-reports-time/';
  static const api_income_time = 'api/api-reports-income/';
  static const api_outcome_time = 'api/api-reports-outcome/';
  static const api_revenue_time = 'api/api-reports-revenue/';
}
