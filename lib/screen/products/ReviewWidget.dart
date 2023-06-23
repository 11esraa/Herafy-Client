import 'package:flutter/material.dart';
import 'package:herafy/main.dart';
import 'package:herafy/screen/main/utils/flutter_rating_bar.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/AppColors.dart';

class ReviewWidget extends StatefulWidget {
  static String tag = '/ReviewWidget';
  final List list;
  final bool? enableScrollPhysics;

  const ReviewWidget({super.key, required this.list, this.enableScrollPhysics});

  @override
  ReviewWidgetState createState() => ReviewWidgetState();
}

class ReviewWidgetState extends State<ReviewWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      itemCount: widget.list.length,
      itemBuilder: (_, index) {
        var data = widget.list[index];

        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(16),
          decoration: boxDecorationRoundedWithShadow(8,
              backgroundColor: appStore.appBarColor!),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: appColorPrimary),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.person_outline, color: white),
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['name'], style: boldTextStyle()),
                  Row(
                    children: [
                      IgnorePointer(
                        child: RatingBar(
                          onRatingUpdate: (r) {},
                          itemSize: 14.0,
                          itemBuilder: (context, _) =>
                              const Icon(Icons.star, color: Colors.amber),
                          initialRating: data['rate'],
                        ),
                      ),
                      16.width,
                      Text(data['rate'].toString(),
                          style: secondaryTextStyle()),
                    ],
                  ),
                  Text(data['review'], style: secondaryTextStyle()),
                ],
              ).expand(),
            ],
          ),
        );
      },
      physics: widget.enableScrollPhysics.validate(value: true)
          ? const ScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
