import 'package:flutter/material.dart';

const greenPointColor = Color(0xff34AFA1);

class ResidenceScreen extends StatelessWidget {
  const ResidenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppBar(),
    );
  }
}

AppBar _buildAppBar (){
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    centerTitle: false,
    title: Row(
      children: const [
        Chip(
          backgroundColor: Color(0xffE9EFEE),
          labelPadding: EdgeInsets.symmetric(horizontal: 10),
          label: Text('カウルのおすすめ',
            style: TextStyle(
                color: greenPointColor,
                fontWeight: FontWeight.bold,
                fontSize: 13),),
        ),
        SizedBox(width: 8),
        Chip(
          backgroundColor: Color(0xffE9EFEE),
          labelPadding: EdgeInsets.symmetric(horizontal: 10),
          label: Text('カウルのおすすめ',
            style: TextStyle(
                color: greenPointColor,
                fontWeight: FontWeight.bold,
                fontSize: 13),),
        ),
      ],
    ),
    leadingWidth: 110,
    actions: [
      IconButton(
        icon: const Icon(Icons.add_circle,size: 35,color: greenPointColor,),
        onPressed: () {},
      ),
    ],
  );
}