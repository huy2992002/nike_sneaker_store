import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/view/widgets/cart_value_item.dart';
import 'package:nike_sneaker_store/gen/fonts.gen.dart';
import 'package:nike_sneaker_store/l10n/app_localizations.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/utils/extension.dart';
import 'package:provider/provider.dart';

class CartTotalCost extends StatelessWidget {
  const CartTotalCost({
    this.onCheckout,
    super.key,
    this.canCheckOut = false,
    this.isDisable = false,
  });

  final Function()? onCheckout;
  final bool canCheckOut;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    double subTotal() {
      double subTotal = 0;
      final myCarts = context.read<CartBloc>().state.myCarts;
      for (ProductModel pr in myCarts) {
        subTotal += (pr.price ?? 0) * (pr.quantity ?? 0);
      }
      return subTotal;
    }

    double delivery() {
      if (subTotal() == 0.0) {
        return 0;
      } else {
        return 60;
      }
    }

    double totalCost = subTotal() + delivery();
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CartValueItem(
            title: AppLocalizations.of(context).subTotal,
            value: subTotal().toPriceDollar(),
          ),
          const SizedBox(height: 10),
          CartValueItem(
            title: AppLocalizations.of(context).delivery,
            value: delivery().toPriceDollar(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: DottedLine(
              dashColor: Theme.of(context).colorScheme.surfaceTint,
            ),
          ),
          Row(
            children: [
              Text(
                AppLocalizations.of(context).totalCost,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.surfaceTint,
                    ),
              ),
              const Spacer(),
              Text(
                totalCost.toPriceDollar(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: FontFamily.poppins,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          NSElevatedButton.text(
            onPressed: canCheckOut ? onCheckout : null,
            text: AppLocalizations.of(context).checkOut,
            backgroundColor: !canCheckOut
                ? Theme.of(context).colorScheme.surfaceTint
                : Theme.of(context).colorScheme.primary,
            isDisable: isDisable,
          ),
        ],
      ),
    );
  }
}
