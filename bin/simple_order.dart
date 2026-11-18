const menu = {'Adobo rice': 85.0, 'Iced tea': 35.0, 'Turon': 25.0};

class OrderItem {
  final String name;
  final double price;
  final int qty;

  OrderItem(this.name, this.price, this.qty);

  double get subtotal => price * qty;
}

OrderItem orderOf(String name, int qty) {
  final price = menu[name];
  if (price == null) {
    throw ArgumentError('$name is not on the menu');
  }
  return OrderItem(name, price, qty);
}

double total(List<OrderItem> items) =>
    items.fold(0.0, (sum, item) => sum + item.subtotal);

void printReceipt(List<OrderItem> items, {String? customer}) {
  final subtotal = total(items);
  final discount = subtotal >= 300 ? subtotal * 0.10 : 0.0;

  String line(String label, double amount) =>
      label.padRight(18) + amount.toStringAsFixed(2).padLeft(7);

  print('Order for ${customer ?? 'Guest'}');
  for (final item in items) {
    print(line('${item.qty} x ${item.name}', item.subtotal));
  }
  print(line('Subtotal', subtotal));
  if (discount > 0) {
    print(line('Discount 10%', -discount));
  }
  print(line('Total', subtotal - discount));
}

void main() {
  final order1 = [
    orderOf('Adobo rice', 3),
    orderOf('Iced tea', 1),
    orderOf('Turon', 3),
  ];
  printReceipt(order1);

  print('');

  final order2 = [
    orderOf('Adobo rice', 2),
    orderOf('Iced tea', 1),
  ];
  printReceipt(order2, customer: 'Jasper');
}