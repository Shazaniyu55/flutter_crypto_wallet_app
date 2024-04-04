// ignore_for_file: file_names, unnecessary_new, prefer_collection_literals

class FeeModel {
  String? feeName;
  String? createdAt;
  num? feePercentage;
  String? updatedAt;
  String? id;

  FeeModel(
      {this.feeName,
        this.createdAt,
        this.feePercentage,
        this.updatedAt,
        this.id});

  FeeModel.fromJson(Map<String, dynamic> json) {
    feeName = json['feeName'];
    createdAt = json['createdAt'];
    feePercentage = json['feePercentage'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feeName'] = feeName;
    data['createdAt'] = createdAt;
    data['feePercentage'] = feePercentage;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}