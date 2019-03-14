



class JobPositionModel {
  String id;
  String type;
  String url;
  String createdAt;
  String company;
  String companyUrl;
  String location;
  String title;
  String description;
  String howToApply;
  String companyLogo;

  JobPositionModel(
      {this.id,
        this.type,
        this.url,
        this.createdAt,
        this.company,
        this.companyUrl,
        this.location,
        this.title,
        this.description,
        this.howToApply,
        this.companyLogo});

  JobPositionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    url = json['url'];
    createdAt = json['created_at'];
    company = json['company'];
    companyUrl = json['company_url'];
    location = json['location'];
    title = json['title'];
    description = json['description'];
    howToApply = json['how_to_apply'];
    companyLogo = json['company_logo'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['company'] = this.company;
    data['company_url'] = this.companyUrl;
    data['location'] = this.location;
    data['title'] = this.title;
    data['description'] = this.description;
    data['how_to_apply'] = this.howToApply;
    data['company_logo'] = this.companyLogo;
    return data;
  }
}
