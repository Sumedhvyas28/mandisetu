import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductLoading extends StatelessWidget {
  const ProductLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade200,
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white10,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Container(
                width: 150,
                height: 150,
                  color: Colors.grey.shade300,
              ),

              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: 100,
                          height: 30,
                          color: Colors.grey.shade300,
                        ),

                        const SizedBox(height: 20),

                        Container(
                          width: 150,
                          height: 15,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 150,
                          height: 15,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 150,
                          height: 15,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 10),


                      ],
                    ),
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
