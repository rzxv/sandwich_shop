import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      // Use OrderScreen as home, setting maxQuantity to 5
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

class OrderScreen extends StatefulWidget {
  // maxQuantity is immutable and defines the limit
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;

  void _increaseQuantity() {
    // Check against the immutable maxQuantity accessed via 'widget'
    if (_quantity < widget.maxQuantity) {
      // Must call setState() to trigger a UI rebuild
      setState(() => _quantity++);
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      // Must call setState() to trigger a UI rebuild
      setState(() => _quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final VoidCallback? increaseCallback = _quantity < widget.maxQuantity
        ? _increaseQuantity
        : null;

    final VoidCallback? decreaseCallback = _quantity > 0
        ? _decreaseQuantity
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Sandwich Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // We use the mutable state variable _quantity
            OrderItemDisplay(_quantity, 'Footlong'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: StyledButton(
                    onPressed: increaseCallback, // Use conditional callback
                    text: 'Add',
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StyledButton(
                    onPressed: decreaseCallback, // Use conditional callback
                    text: 'Remove',
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StyledButton extends StatelessWidget {
  final VoidCallback? onPressed; // The function to call when pressed
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  const StyledButton({
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      child: Text(text),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String itemType;

  const OrderItemDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text('$quantity $itemType sandwich(es): ${'🥪' * quantity}');
  }
}
