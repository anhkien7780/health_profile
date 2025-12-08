import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/models/entities/selection_item.dart';
import 'package:health_profile/ui/pages/book_appointment/widgets/selection_bottom_sheet.dart';

class AppNavigator {
  BuildContext context;

  AppNavigator(this.context);

  void pop<T extends Object?>([T? result]) {
    return context.pop(result);
  }

  Future<dynamic> pushNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    return context.pushNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  Future<dynamic> pushReplacementNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    return context.pushReplacementNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  void showSelectionSheet({
    required String title,
    required List<SelectionItem> items,
    required Function(SelectionItem) onItemSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SelectionBottomSheet(
        searchHint: title,
        items: items,
        onItemSelected: onItemSelected,
      ),
      backgroundColor: Colors.transparent,
    );
  }

  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
