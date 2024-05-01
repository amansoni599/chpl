class ProductList {
  int? status;
  String? msg;
  String? link;
  List<Product>? product;
  List<Group>? group;
  List<Maingroup>? maingroup;

  ProductList(
      {this.status,
      this.msg,
      this.link,
      this.product,
      this.group,
      this.maingroup});

  ProductList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    link = json['link'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
    if (json['group'] != null) {
      group = <Group>[];
      json['group'].forEach((v) {
        group!.add(Group.fromJson(v));
      });
    }
    if (json['maingroup'] != null) {
      maingroup = <Maingroup>[];
      json['maingroup'].forEach((v) {
        maingroup!.add(Maingroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['link'] = link;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    if (group != null) {
      data['group'] = group!.map((v) => v.toJson()).toList();
    }
    if (maingroup != null) {
      data['maingroup'] = maingroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? prdImage;
  int? prdId;
  String? prdCode;
  String? prdName;
  String? prdShortname;
  int? grpId;
  int? rate;
  int buyCount = 0;

  Product(
      {this.prdImage,
      this.prdId,
      this.prdCode,
      this.prdName,
      this.prdShortname,
      this.grpId,
      this.rate});

  Product.fromJson(Map<String, dynamic> json) {
    prdImage = json['prd_image'];
    prdId = json['prd_id'];
    prdCode = json['prd_code'];
    prdName = json['prd_name'];
    prdShortname = json['prd_shortname'];
    grpId = json['grp_id'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['prd_image'] = prdImage;
    data['prd_id'] = prdId;
    data['prd_code'] = prdCode;
    data['prd_name'] = prdName;
    data['prd_shortname'] = prdShortname;
    data['grp_id'] = grpId;
    data['rate'] = rate;
    return data;
  }
}

class Group {
  int? grpId;
  int? groupId;
  String? grpCode;
  String? grpName;

  Group({this.grpId, this.groupId, this.grpCode, this.grpName});

  Group.fromJson(Map<String, dynamic> json) {
    grpId = json['grp_id'];
    groupId = json['group_id'];
    grpCode = json['grp_code'];
    grpName = json['grp_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['grp_id'] = grpId;
    data['group_id'] = groupId;
    data['grp_code'] = grpCode;
    data['grp_name'] = grpName;
    return data;
  }
}

class Maingroup {
  int? groupId;
  int? seq;
  String? name;

  Maingroup({this.groupId, this.seq, this.name});

  Maingroup.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    seq = json['seq'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group_id'] = groupId;
    data['seq'] = seq;
    data['name'] = name;
    return data;
  }
}
