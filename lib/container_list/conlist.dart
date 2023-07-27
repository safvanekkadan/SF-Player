import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class ContainerList extends StatelessWidget {
  final String name;
  final Icon icon;
  final Color color;
  
  const ContainerList({
    super.key,
    required this.name,
    required this.color,
    required this.icon });

  @override
  Widget build(BuildContext context) {
  
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Container(    
         
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              name,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}