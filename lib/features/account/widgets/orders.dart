import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  //Temporary List for demo - list of images of products 
  List list = [
    "https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjZ8fExhcHRvcHxlbnwwfHwwfHx8MA%3D%3D",
    "https://images.unsplash.com/photo-1609085174857-cfea32ae0140?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjd8fElwaG9uZXxlbnwwfHwwfHx8MA%3D%3D",
    "https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjZ8fExhcHRvcHxlbnwwfHwwfHx8MA%3D%3D",
    "https://images.unsplash.com/photo-1609085174857-cfea32ae0140?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mjd8fElwaG9uZXxlbnwwfHwwfHx8MA%3D%3D",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
                ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "See All",
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,            
                ),
                ),
            ),
          ],
        ),
        //Display Orders
        Container(
          height:  170,
          padding: const EdgeInsets.only(left: 10,top:20,right: 0), // because its going to be scrollable
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return SingleProduct(image: list[index],);
            },),
        ),
      ],
    );
  }
}