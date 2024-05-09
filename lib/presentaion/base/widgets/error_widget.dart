import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:weather_app/domain/base/state.dart';

class ErrorPlaceholder extends StatelessWidget {
  final Failure<dynamic> errorState;
  final void Function()? retry;

  const ErrorPlaceholder({super.key, required this.errorState, this.retry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/ic_error.png'),
        Text(
          errorState.message!,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        retry != null
            ? ElevatedButton(onPressed: retry, child: const Text('Retry'))
            : Container()
      ],
    );
  }
}
