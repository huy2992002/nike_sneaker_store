extension ExString on double {
  /// Extension helps convert from a double number to a String to display dollars
  String toPriceDollar() {
    return '\$ ${toStringAsFixed(2)}';
  }

}
