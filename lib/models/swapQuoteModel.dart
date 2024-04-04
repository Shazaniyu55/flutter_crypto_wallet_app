// ignore_for_file: file_names, prefer_collection_literals

class SwapQuoteModel {
  String? swapAmount;
  String? recievedSwapedAmount;
  BridgeFee? bridgeFee;
  String? srcPriceImpact;
  String? destinationPriceImpact;
  bool? isSwapPossible;
  String? total;

  SwapQuoteModel(
      {this.swapAmount,
        this.recievedSwapedAmount,
        this.bridgeFee,
        this.srcPriceImpact,
        this.destinationPriceImpact,
        this.isSwapPossible,
        this.total});

  SwapQuoteModel.fromJson(Map<String, dynamic> json) {
    swapAmount = json['swapAmount'];
    recievedSwapedAmount = json['recievedSwapedAmount'];
    bridgeFee = json['bridgeFee'] != null
        ? BridgeFee.fromJson(json['bridgeFee'])
        : null;
    srcPriceImpact = json['srcPriceImpact'];
    destinationPriceImpact = json['destinationPriceImpact'];
    isSwapPossible = json['isSwapPossible'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['swapAmount'] = swapAmount;
    data['recievedSwapedAmount'] = recievedSwapedAmount;
    if (bridgeFee != null) {
      data['bridgeFee'] = bridgeFee!.toJson();
    }
    data['srcPriceImpact'] = srcPriceImpact;
    data['destinationPriceImpact'] = destinationPriceImpact;
    data['isSwapPossible'] = isSwapPossible;
    data['total'] = total;
    return data;
  }
}

class BridgeFee {
  String? token;
  String? symbol;
  String? amount;
  String? amountInEth;
  double? amountInUSD;

  BridgeFee(
      {this.token,
        this.symbol,
        this.amount,
        this.amountInEth,
        this.amountInUSD});

  BridgeFee.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    symbol = json['symbol'];
    amount = json['amount'];
    amountInEth = json['amountInEth'];
    amountInUSD = json['amountInUSD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    data['symbol'] = symbol;
    data['amount'] = amount;
    data['amountInEth'] = amountInEth;
    data['amountInUSD'] = amountInUSD;
    return data;
  }
}