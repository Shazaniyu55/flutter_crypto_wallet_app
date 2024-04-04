// ignore_for_file: file_names, prefer_collection_literals

class UserModel {
  String? fullname;
  String? image;
  String? email;
  String? username;
  String? phone;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? authSecret;
  String? authUrl;
  bool? isAuthEnabled;
  bool? isBiometricEnabled;
  bool? isAdmin;
  bool? isSuperAdmin;
  bool? isVerified;
  bool? isActive;
  bool? isDeleted;
  String? currencyId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Currency? currency;
  String? id;

  UserModel(
      {this.fullname,
        this.image,
        this.email,
        this.username,
        this.phone,
        this.bankName,
        this.accountNumber,
        this.accountName,
        this.authSecret,
        this.authUrl,
        this.isAuthEnabled,
        this.isBiometricEnabled,
        this.isAdmin,
        this.isSuperAdmin,
        this.isVerified,
        this.isActive,
        this.isDeleted,
        this.currencyId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.currency,
        this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    image = json['image'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
    authSecret = json['authSecret'];
    authUrl = json['authUrl'];
    isAuthEnabled = json['isAuthEnabled'];
    isBiometricEnabled = json['isBiometricEnabled'];
    isAdmin = json['isAdmin'];
    isSuperAdmin = json['isSuperAdmin'];
    isVerified = json['isVerified'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    currencyId = json['currencyId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    currency = json['currency'] != null
        ? Currency.fromJson(json['currency'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fullname'] = fullname;
    data['image'] = image;
    data['email'] = email;
    data['username'] = username;
    data['phone'] = phone;
    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    data['accountName'] = accountName;
    data['authSecret'] = authSecret;
    data['authUrl'] = authUrl;
    data['isAuthEnabled'] = isAuthEnabled;
    data['isBiometricEnabled'] = isBiometricEnabled;
    data['isAdmin'] = isAdmin;
    data['isSuperAdmin'] = isSuperAdmin;
    data['isVerified'] = isVerified;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    data['currencyId'] = currencyId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class Currency {
  String? sId;
  String? name;
  String? symbol;
  String? coinGeckoId;
  String? logoUrl;
  bool? isDeleted;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;

  Currency(
      {this.sId,
        this.name,
        this.symbol,
        this.coinGeckoId,
        this.logoUrl,
        this.isDeleted,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.id});

  Currency.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    symbol = json['symbol'];
    coinGeckoId = json['coinGeckoId'];
    logoUrl = json['logoUrl'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['symbol'] = symbol;
    data['coinGeckoId'] = coinGeckoId;
    data['logoUrl'] = logoUrl;
    data['isDeleted'] = isDeleted;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['id'] = id;
    return data;
  }
}