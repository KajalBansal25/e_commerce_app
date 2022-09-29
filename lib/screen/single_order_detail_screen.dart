import 'package:e_commerce_app/utils/scaling.dart';
import 'package:flutter/material.dart';

class SingleOrderDetailScreen extends StatefulWidget {
  const SingleOrderDetailScreen({Key? key}) : super(key: key);

  @override
  State<SingleOrderDetailScreen> createState() =>
      _SingleOrderDetailScreenState();
}

class _SingleOrderDetailScreenState extends State<SingleOrderDetailScreen> {
  int currentStep = 0;
  List<Step> getSteps() => [
        Step(
          title: const Text('Ordered'),
          subtitle: const Text('Date and time'),
          content: SizedBox(height: normalizedHeight(context, 0)),
          state: StepState.complete,
          isActive: true,
        ),
        Step(
          title: const Text('Packed'),
          subtitle: const Text('Date and time'),
          content: SizedBox(
            height: normalizedHeight(context, 0),
          ),
          state: StepState.complete,
          isActive: true,
        ),
        Step(
          title: const Text('Shipped'),
          subtitle: const Text('Date and time'),
          content: SizedBox(
            height: normalizedHeight(context, 0),
          ),
          isActive: true,
          state: StepState.complete,
        ),
        Step(
          title: const Text('Delivery'),
          subtitle: const Text('Date and time'),
          content: SizedBox(
            height: normalizedHeight(context, 0),
          ),
          isActive: false,
          state: StepState.indexed,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: normalizedWidth(context, 15)!,
                    vertical: normalizedHeight(context, 15)!),
                child: const Text('Order ID - OD111111111111111'),
              ),
              Divider(
                height: normalizedHeight(context, 1),
                thickness: normalizedWidth(context, 1),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: normalizedWidth(context, 15)!,
                    vertical: normalizedHeight(context, 15)!),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: normalizedWidth(context, 250),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Product Detail',
                            style: TextStyle(
                                fontSize: normalizedWidth(context, 19),
                                fontWeight: FontWeight.bold),
                          ),
                          const Text('Color'),
                          SizedBox(
                            height: normalizedHeight(context, 8),
                          ),
                          const Text('Seller details'),
                          SizedBox(
                            height: normalizedHeight(context, 8),
                          ),
                          Text(
                            '\$ 140',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: normalizedWidth(context, 24),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: normalizedWidth(context, 5)!,
                          vertical: normalizedHeight(context, 5)!),
                      child: SizedBox(
                        height: normalizedHeight(context, 80),
                        width: normalizedWidth(context, 60),
                        child: const Image(
                          image: NetworkImage(
                              "https://fakestoreapi.com/img/51eg55uWmdL._AC_UX679_.jpg"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: normalizedHeight(context, 1),
                thickness: normalizedWidth(context, 1),
              ),
              Stepper(
                steps: getSteps(),
                type: StepperType.vertical,
                currentStep: currentStep,
                onStepTapped: (step) {
                  setState(() {
                    currentStep = step;
                  });
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return Row(
                    children: const <Widget>[],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
