import 'package:flutter/material.dart';
    
class FindNewVideosWidget extends StatelessWidget {
  final VoidCallback onTap;

  const FindNewVideosWidget({
    super.key,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text("Nenhum video Econtrado..",
          style: TextStyle(color: Colors.white),
          ),
          ElevatedButton(
              onPressed: onTap,
              child: Text('Buscar videos')),
        ],
      ),
    );
  }
}