import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skiome_schools/models/objects.dart';

class CartObjectDesignWidget extends StatefulWidget {
  Objects? model;
  int? quantityNumber;
  CartObjectDesignWidget({
    this.model,
    this.quantityNumber,
  });

  @override
  State<CartObjectDesignWidget> createState() => _CartObjectDesignWidgetState();
}

class _CartObjectDesignWidgetState extends State<CartObjectDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF2a4371),
      shadowColor: Colors.white54,
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              //image
              Image.network(
                widget.model!.thumbnailUrl.toString(),
                width: 140,
                height: 120,
              ),
              const SizedBox(
                width: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //title
                    Text(
                      widget.model!.objectName.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    //Price: Rs.10
                    Row(
                      children: [
                        const Text(
                          "Price: ",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Rs." + widget.model!.objectPrice.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    //Quantity: 5
                    Row(
                      children: [
                        const Text(
                          "Quantity: ",
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          widget.quantityNumber.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
