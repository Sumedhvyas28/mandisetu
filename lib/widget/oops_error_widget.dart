import 'package:flutter/material.dart';

class OopsErrorWidget extends StatelessWidget {
  const OopsErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(":(", style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(height: 20),
            Text("OOPS!", style: Theme.of(context).textTheme.headlineSmall,),
            Text("Something went wrong!", style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
      ),
    );
  }
}
