import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF4C53A5),
              size: 30.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Cart',
              style: TextStyle(
                color: Color(0xFF4C53A5),
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          const Icon(Icons.more_vert, color: Color(0xFF4C53A5), size: 30.0),
        ],
      ),
    );
  }
}