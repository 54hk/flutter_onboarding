import 'package:flutter/material.dart';

class PageIndiator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;

  PageIndiator(this.currentIndex, this.pageCount);

  _indiator(bool isActive) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:4.0),
        child: Container(
          height: 4,
          decoration: BoxDecoration(
              color: isActive ? Colors.white : Color(0xFF3E4750),
              boxShadow: [
                BoxShadow(color: Colors.red, offset: Offset.zero, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  _buildPageIndicators() {
    List<Widget> indiatorList = [];
    for (int i = 0; i < pageCount; i++) {
      indiatorList.add(i == currentIndex ? _indiator(true) : _indiator(false));
    }
    return indiatorList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildPageIndicators(),
    );
  }
}
