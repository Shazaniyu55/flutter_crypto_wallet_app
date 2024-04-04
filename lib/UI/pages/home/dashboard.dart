// ignore_for_file: prefer_final_fields, sized_box_for_whitespace, unnecessary_string_interpolations, sort_child_properties_last, prefer_interpolation_to_compose_strings, deprecated_member_use, use_super_parameters

import 'package:benex/UI/pages/chooseToken/chooseToken.dart';
import 'package:benex/UI/pages/history/history.dart';
import 'package:benex/services/apiService.dart';
import 'package:benex/services/utilServices.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colors.dart';
import '../../../controllers/appController.dart';
import '../../../models/coinsModel.dart';
import '../../../models/walletBalanceModel.dart';
import '../../common_widgets/commonWidgets.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int currentMax = 1;
  AppController appController = Get.find<AppController>();
  var selectedCoin = CoinsModel().obs;
  var selectedCoinToBalanceModel = Balance().obs;
  var selectCoin = 0.obs;
  getUserData() async {
    appController.getBalanceLoader.value = true;
    ApiService().getLoggedInUser().then((value) {
      if (value == 'OK') {
        ApiService().getAllCoins(limit: 30, offset: 0).then((value) {
          if (value == 'OK') {
            selectedCoin.value = appController.allCoinsList[0];
            selectedCoinToBalanceModel.value.logoUrl = selectedCoin.value.icon;
            selectedCoinToBalanceModel.value.price = selectedCoin.value.price;
            selectedCoinToBalanceModel.value.networkId =
                selectedCoin.value.networkId!.id;
            selectedCoinToBalanceModel.value.coinId = selectedCoin.value.id;
          }
        });
        ApiService().getWalletWithBalance();
        _refreshController.refreshCompleted();
      }
    });
    appController.shouldCallDashboardApi.value = false;
    //print(appController.user.value?.id);
  }

  @override
  void initState() {
    super.initState();
    if (appController.shouldCallDashboardApi.value == true) {
      getUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: appBgGradient,
      ),
      child: Scaffold(
        ///backgroundColor: primaryColor.value,
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: primaryColor.value,

              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
            elevation: 0,
          ),
        ),
        body: Obx(
          () => Container(
            height: Get.height,
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              header: WaterDropMaterialHeader(
                backgroundColor: primaryBackgroundColor.value,
                color: primaryColor.value,
              ),
              controller: _refreshController,
              onRefresh: () {
                onRefresh();
              },
              onLoading: () {},
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 210,
                        padding:
                            const EdgeInsets.only(top: 30, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: Get.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Available Balance',
                                    style: TextStyle(
                                      fontFamily: 'sfpro',
                                      color: lightColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      letterSpacing: 0.37,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '${appController.user.value.currency?.symbol ?? ''}${UtilService().toFixed2DecimalPlaces((appController.userBalance.value.wallet?.totalBalanceInLocalCurrency ?? 0).toString())}',
                                    style: TextStyle(
                                      fontFamily: 'sfpro',
                                      color: lightColor,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 40.0,
                                      letterSpacing: 0.36,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          decoration: BoxDecoration(
                            color: primaryBackgroundColor.value,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          //constraints: BoxConstraints(minHeight: Get.height - 240, minWidth: Get.width),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              Expanded(
                                child: appController.getBalanceLoader.value ==
                                        true
                                    ? ListView.separated(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(
                                            top: 16, bottom: 16),
                                        itemCount: 8,
                                        itemBuilder:
                                            (BuildContext context, int index) =>
                                                Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.25),
                                          highlightColor:
                                              Colors.grey.withOpacity(0.5),
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            width: Get.width,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(height: 16);
                                        },
                                      )
                                    : AnimationLimiter(
                                        child: ListView.builder(
                                          itemCount: appController.userBalance
                                                  .value.balance?.length ??
                                              0,
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 40),
                                          itemBuilder: (context, i) {
                                            bool inc = (appController
                                                            .userBalance
                                                            .value
                                                            .balance?[i]
                                                            .priceChange ??
                                                        0) >
                                                    0
                                                ? true
                                                : false;
                                            return AnimationConfiguration
                                                .staggeredList(
                                              position: i,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              child: SlideAnimation(
                                                verticalOffset: 10.0,
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                child: FadeInAnimation(
                                                  child: _coinRow(
                                                    coinName:
                                                        '${appController.userBalance.value.balance?[i].symbol ?? ''}',
                                                    priceInUSD:
                                                        '${UtilService().toFixed2DecimalPlaces((appController.userBalance.value.balance?[i].price ?? 0).toString())}',
                                                    imgName:
                                                        '${appController.userBalance.value.balance?[i].logoUrl}',
                                                    percentage:
                                                        '${UtilService().toFixed2DecimalPlaces((appController.userBalance.value.balance?[i].priceChange ?? 0).toString(), decimalPlaces: 2)}',
                                                    amountInEth:
                                                        '${UtilService().toFixed2DecimalPlaces((appController.userBalance.value.balance?[i].balance ?? 0).toString(), decimalPlaces: 4)}',
                                                    amountInUSD:
                                                        '${UtilService().toFixed2DecimalPlaces((appController.userBalance.value.balance?[i].balanceInLocalCurrency ?? 0).toString(), decimalPlaces: 4)}',
                                                    increment: inc,
                                                    token: appController
                                                        .userBalance
                                                        .value
                                                        .balance?[i],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 170,
                    left: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: Get.width - 32,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: cardColor.value,
                            boxShadow: appShadow),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Row(
                          children: [
                            _dashBTns(
                                svg: 'send',
                                btnText: 'Withdraw',
                                onTap: () {
                                  //Get.to(ChooseToken(fromPage: 'send',));
                                  CommonWidgets()
                                      .selectWithdrawBottomSheet(context);
                                }),
                            _dashBTns(
                                svg: 'recieve',
                                btnText: 'Receive',
                                onTap: () {
                                  String address;
                                  Get.to(const ChooseToken(
                                    fromPage: 'receive',
                                  ))?.then((value) {
                                    if (value != null) {
                                      address = (value.networkName == 'Tron')
                                          ? (appController.userBalance.value
                                                  .wallet?.tronAddress ??
                                              '')
                                          : (value.networkName == 'Bitcoin' ||
                                                  value.networkName ==
                                                      'Bitcoin (Testnet)')
                                              ? (appController.userBalance.value
                                                      .wallet?.btcAddress ??
                                                  '')
                                              : (appController.userBalance.value
                                                      .wallet?.evmAddress ??
                                                  '');
                                      _qrBottomSheeet(
                                          context, address, value.symbol);
                                    }
                                  });
                                }),
                            _dashBTns(
                                svg: 'History',
                                btnText: 'History',
                                onTap: () {
                                  Get.to(const History());
                                }),
                            _dashBTns(
                                svg: 'buy',
                                btnText: 'Buy',
                                onTap: () {
                                  Get.to(const ChooseToken(
                                    fromPage: 'buy',
                                  ));
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _coinRow(
      {String? coinName,
      String? amountInEth,
      String? amountInUSD,
      String? percentage,
      String? priceInUSD,
      String? imgName,
      required bool increment,
      Balance? token}) {
    return GestureDetector(
      onTap: () {
        //Get.to(CoinHistory(token: token!,));
      },
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.transparent,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imgName ?? '',
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    clipBehavior: Clip.antiAlias,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '$coinName',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              color: headingColor.value,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              letterSpacing: 0.37,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            '${appController.user.value.currency?.symbol}$priceInUSD',
                            style: TextStyle(
                              fontFamily: 'sfpro',
                              color: placeholderColor,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              letterSpacing: 0.44,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          increment == true
                              ? Text(
                                  '+ $percentage%',
                                  style: TextStyle(
                                      fontFamily: 'sfpro',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.0,
                                      letterSpacing: 0.44,
                                      color: greenCardColor.value),
                                )
                              : Text(
                                  ' $percentage%',
                                  style: TextStyle(
                                      fontFamily: 'sfpro',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.0,
                                      letterSpacing: 0.44,
                                      color: redCardColor.value),
                                ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '$amountInEth',
                        style: TextStyle(
                          fontFamily: 'sfpro',
                          color: headingColor.value,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          letterSpacing: 0.37,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${appController.user.value.currency?.symbol}$amountInUSD',
                    style: TextStyle(
                      fontFamily: 'sfpro',
                      color: placeholderColor,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      letterSpacing: 0.44,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dashBTns({String? svg, String? btnText, Function? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(
                      'assets/svgs/$svg.svg',
                      color: inputFieldTextColor.value,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '$btnText',
                style: TextStyle(
                  fontFamily: 'sfpro',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  letterSpacing: 0.37,
                  color: inputFieldTextColor.value,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _qrBottomSheeet(
      BuildContext context, String address, String coinSymbol) {
    return Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        height: Get.height * 0.63,
        decoration: BoxDecoration(
            color: primaryBackgroundColor.value,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Receive",
                  style: TextStyle(
                      fontFamily: 'sfpro',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 26.0,
                      letterSpacing: 0.44,
                      color: headingColor.value),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.clear,
                      color: headingColor.value,
                    ))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: lightColor),
              padding: const EdgeInsets.all(6),
              child: QrImageView(
                data: "$address",
                version: QrVersions.auto,
                size: 200.0,
                // backgroundColor: headingColor.value,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Send only ($coinSymbol) to this address.\nSending any other coins may result in permanent loss.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'sfpro',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  fontSize: 11.0,
                  letterSpacing: 0.44,
                  color: placeholderColor),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                UtilService().copyToClipboard(address);
              },
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: bSheetbtnColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      const AssetImage("assets/imgs/Icons1.png"),
                      color: primaryColor.value,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      '${address.substring(0, 5) + '...' + address.substring(address.length - 4)}',
                      style: TextStyle(
                          fontFamily: 'sfpro',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          letterSpacing: 0.44,
                          color: primaryColor.value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  onRefresh() async {
    appController.getBalanceLoader.value = true;
    appController.userWalletsLoader.value = true;
    getUserData();
  }
}
