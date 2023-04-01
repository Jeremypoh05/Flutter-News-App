import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key, required this.newsType}) : super(key: key);
  final NewsType newsType;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  BorderRadius borderRadius = BorderRadius.circular(18);
  late Color baseShimmerColor,
      highlightShimmerColor,
      widgetShimmerColor; //initialize

  @override
  //This method is called when a dependency of the widget changes.
  // In this case, it is used to initialize the shimmer colors based on the context.
  void didChangeDependencies() {
    //we can access the context since it is a stateful widget
    var utils = Utils(context);
    baseShimmerColor = utils.baseShimmerColor;
    highlightShimmerColor = utils.highlightShimmerColor;
    widgetShimmerColor = utils.widgetShimmerColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    //since we initialize the newsType in the stateful widget above, we need to put widget.newsType
    return widget.newsType == NewsType.topTrending
        ? Swiper(
            autoplay: true,
            autoplayDelay: 7000,
            itemWidth: size.width * 0.85,
            layout: SwiperLayout.STACK,
            viewportFraction: 0.9,
            //viewPort become small a bit
            itemCount: 5,
            itemBuilder: (context, index) {
              return TopTrendingShimmerEffectWidget(
                  baseShimmerColor: baseShimmerColor,
                  highlightShimmerColor: highlightShimmerColor,
                  size: size,
                  widgetShimmerColor: widgetShimmerColor,
                  borderRadius: borderRadius);
            })
        : Expanded(
            //ListView widget is used to display a scrollable list of items.
            child: ListView.builder(
                //shrinkWrap property is used to indicate whether the ListView should adjust its size to wrap the contents of the list
                //When shrinkWrap is set to true, the ListView will take up only the required space to display its children.
                shrinkWrap: true,
                //physics property is used to control the scrolling physics of the ListView
                //NeverScrollableScrollPhysics() is used to create a scroll physics that does not allow the user to scroll the list view. This means that the list view will not respond to any user input to scroll it
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ArticlesShimmerEffectWidget(
                      baseShimmerColor: baseShimmerColor,
                      highlightShimmerColor: highlightShimmerColor,
                      widgetShimmerColor: widgetShimmerColor,
                      size: size,
                      borderRadius: borderRadius);
                }),
          );
  }
}

class TopTrendingShimmerEffectWidget extends StatelessWidget {
  const TopTrendingShimmerEffectWidget({
    super.key,
    required this.baseShimmerColor,
    required this.highlightShimmerColor,
    required this.size,
    required this.widgetShimmerColor,
    required this.borderRadius,
  });

  final Color baseShimmerColor;
  final Color highlightShimmerColor;
  final Size size;
  final Color widgetShimmerColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        //this is the flutter package. For more details, read here: https://pub.dev/packages/shimmer
        child: Shimmer.fromColors(
          baseColor: baseShimmerColor,
          highlightColor: highlightShimmerColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //----Shimmer Effect For Image----
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: size.height * 0.32,
                  width: double.infinity,
                  color: widgetShimmerColor,
                ),
              ),
              //----Shimmer Effect For Title----
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: widgetShimmerColor,
                  ),
                ),
              ),
              //----Shimmer Effect For Date----
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: size.height * 0.025,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: borderRadius,
                    color: widgetShimmerColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//doing by extracting new flutter widget
//Creating another widget called ArticlesShimmerEffectWidget which will be used to display the shimmering effect.
class ArticlesShimmerEffectWidget extends StatelessWidget {
  const ArticlesShimmerEffectWidget({
    super.key,
    required this.baseShimmerColor,
    required this.highlightShimmerColor,
    required this.widgetShimmerColor,
    required this.size,
    required this.borderRadius,
  });

  final Color baseShimmerColor;
  final Color highlightShimmerColor;
  final Color widgetShimmerColor;
  final Size size;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: Stack(
          children: [
            Container(
              height: 60,
              width: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Container(
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(8.0),
              //this is the flutter package. For more details, read here: https://pub.dev/packages/shimmer
              child: Shimmer.fromColors(
                baseColor: baseShimmerColor,
                highlightColor: highlightShimmerColor,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: widgetShimmerColor,
                        height: size.height * 0.12,
                        width: size.width * 0.23,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.06,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              color: widgetShimmerColor,
                            ),
                          ),
                          const VerticalSpacing(8),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: size.height * 0.025,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                color: widgetShimmerColor,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    color: widgetShimmerColor,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  height: size.height * 0.025,
                                  width: size.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: borderRadius,
                                    color: widgetShimmerColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
