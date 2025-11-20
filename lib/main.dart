import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class StyledButton extends StatelessWidget {
  final VoidCallback? onPressed;
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

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  String _itemType = 'Footlong';

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() => _quantity++);
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
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
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _itemType = 'Six-inch');
                    },
                    child: const Text('Six-inch'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _itemType == 'Six-inch'
                          ? Colors.blue
                          : Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _itemType = 'Footlong');
                    },
                    child: const Text('Footlong'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _itemType == 'Footlong'
                          ? Colors.blue
                          : Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Use the mutable state variable _itemType
            OrderItemDisplay(_quantity, _itemType),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: StyledButton(
                    onPressed: increaseCallback,
                    text: 'Add',
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: StyledButton(
                    onPressed: decreaseCallback,
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

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
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
