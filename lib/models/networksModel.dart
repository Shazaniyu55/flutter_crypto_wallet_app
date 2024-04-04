// ignore_for_file: file_names, prefer_collection_literals

class NetworksModel {
  List<NetworksData>? data;
  int? count;

  NetworksModel({this.data, this.count});

  NetworksModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NetworksData>[];
      json['data'].forEach((v) {
        data!.add(NetworksData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class NetworksData {
  String? name;
  String? symbol;
  int? chainId;
  String? nativeCoinAddress;
  String? logoUrl;
  String? rpcUrl;
  String? chainName;
  String? networkName;
  String? networkType;
  bool? isDeleted;
  bool? isActive;
  bool? isImportAvailable;
  String? id;

  NetworksData(
      {this.name,
        this.symbol,
        this.chainId,
        this.nativeCoinAddress,
        this.logoUrl,
        this.rpcUrl,
        this.chainName,
        this.networkName,
        this.networkType,
        this.isDeleted,
        this.isActive,
        this.isImportAvailable,
        this.id});

  NetworksData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    chainId = json['chainId'];
    nativeCoinAddress = json['nativeCoinAddress'];
    logoUrl = json['logoUrl'];
    rpcUrl = json['rpcUrl'];
    chainName = json['chainName'];
    networkName = json['networkName'];
    networkType = json['networkType'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    isImportAvailable = json['isImportAvailable'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['symbol'] = symbol;
    data['chainId'] = chainId;
    data['nativeCoinAddress'] = nativeCoinAddress;
    data['logoUrl'] = logoUrl;
    data['rpcUrl'] = rpcUrl;
    data['chainName'] = chainName;
    data['networkName'] = networkName;
    data['networkType'] = networkType;
    data['isDeleted'] = isDeleted;
    data['isActive'] = isActive;
    data['isImportAvailable'] = isImportAvailable;
    data['id'] = id;
    return data;
  }
}