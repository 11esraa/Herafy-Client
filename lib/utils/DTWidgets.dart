import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import 'AppColors.dart';
import 'AppWidget.dart';

Widget priceWidget(int? price, {bool applyStrike = false, double? fontSize, Color? textColor}) {
  return Text(
    applyStrike ? '$price' : 'JD $price',
    style: TextStyle(
      decoration: applyStrike ? TextDecoration.lineThrough : TextDecoration.none,
      color: textColor ?? (applyStrike
              ? appStore.textSecondaryColor
              : appStore.textPrimaryColor),
      fontSize: fontSize ?? (applyStrike
              ? 15
              : 18),
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget dot() {
  return Container(
    height: 7,
    width: 7,
    decoration: const BoxDecoration(color: Colors.black12, shape: BoxShape.circle),
  );
}

Gradient defaultThemeGradient() {
  return LinearGradient(
    colors: [
      appColorPrimary,
      appColorPrimary.withOpacity(0.5),
    ],
    tileMode: TileMode.mirror,
    begin: Alignment.topCenter,
    end: Alignment.bottomLeft,
  );
}

Widget errorWidget(BuildContext context, String image, String title, String desc, {bool showRetry = false, Function? onRetry}) {
  return Container(
    constraints: dynamicBoxConstraints(),
    height: context.height(),
    child: Stack(
      children: [
        Image.asset(
          image,
          height: context.height(),
          width: context.width(),
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: Container(
            decoration: boxDecorationRoundedWithShadow(8, backgroundColor: appStore.isDarkModeOn ? Colors.black26 : Colors.white70),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: boldTextStyle(size: 24)),
                4.height,
                Text(desc, style: secondaryTextStyle(size: 14), textAlign: TextAlign.center).paddingOnly(left: 20, right: 20),
                Column(
                  children: [
                    30.height,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        primary: white,
                      ),
                      onPressed: () {
                        onRetry!();
                      },
                      child: Text('RETRY', style: primaryTextStyle(color: textPrimaryColor)),
                    )
                  ],
                ).visible(showRetry),
              ],
            ),
          ),
        )
      ],
    ),
  ).center();
}

Widget totalItemCountWidget(int count) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('Total Items', style: boldTextStyle()),
      Text('$count items', style: boldTextStyle()),
    ],
  );
}

Widget totalAmountWidget(int subTotal, int shippingCharges, int totalAmount) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Sub Total', style: boldTextStyle(size: 18)),
          priceWidget(subTotal),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Shipping Charges', style: boldTextStyle(size: 18)),
          priceWidget(shippingCharges),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Amount', style: boldTextStyle(size: 18)),
          priceWidget(totalAmount),
        ],
      ),
      20.height,
    ],
  );
}


