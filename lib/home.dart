import 'package:flutter/material.dart';
import 'package:pharma/color.dart';
import './export.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myProducts = List<String>.generate(1000, (i) => 'Product $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SizedBox(
        height: heigth(context),
        width: width(context),
        child: Column(
          children: [
            SizedBox(
              height: paddingTop(context),
            ),
            Container(
              height: heigth(context) * 0.08,
              width: width(context),
              color: maincolor,
            ),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: myProducts.length,
                    itemBuilder: (context, index) {
                      return products();
                    }))
          ],
        ),
      )),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        backgroundColor: maincolor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget products() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width(context),
          height: 66,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: maincolor),
                        child: const Icon(
                          Icons.abc_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 8,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(' PARACETAMOLE',style: TextStyle(fontWeight: FontWeight.w600),),
                          SizedBox(height: 2,),
                          Text(' medicament contre la grip....',style: TextStyle(fontWeight: FontWeight.w400,color: Color.fromARGB(255, 111, 156, 164)),)
                        ],
                      )
                    ],
                  ),
                  const Text(' CDF 2000',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                ]),
          ),
        ),
        Container(
          height: 0.6,
          color: maincolor,
        )
      ],
    );
  }
}
