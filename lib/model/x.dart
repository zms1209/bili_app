class X {
  X({
      this.id, 
      this.vid, 
      this.title, 
      this.tname, 
      this.url, 
      this.cover, 
      this.pubdate, 
      this.desc, 
      this.view, 
      this.duration, 
      this.owner, 
      this.reply, 
      this.favorite, 
      this.like, 
      this.coin, 
      this.share, 
      this.createTime, 
      this.size,});

  X.fromJson(dynamic json) {
    id = json['id'];
    vid = json['vid'];
    title = json['title'];
    tname = json['tname'];
    url = json['url'];
    cover = json['cover'];
    pubdate = json['pubdate'];
    desc = json['desc'];
    view = json['view'];
    duration = json['duration'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    reply = json['reply'];
    favorite = json['favorite'];
    like = json['like'];
    coin = json['coin'];
    share = json['share'];
    createTime = json['createTime'];
    size = json['size'];
  }
  String? id;
  String? vid;
  String? title;
  String? tname;
  String? url;
  String? cover;
  int? pubdate;
  String? desc;
  int? view;
  int? duration;
  Owner? owner;
  int? reply;
  int? favorite;
  int? like;
  int? coin;
  int? share;
  String? createTime;
  int? size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['vid'] = vid;
    map['title'] = title;
    map['tname'] = tname;
    map['url'] = url;
    map['cover'] = cover;
    map['pubdate'] = pubdate;
    map['desc'] = desc;
    map['view'] = view;
    map['duration'] = duration;
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    map['reply'] = reply;
    map['favorite'] = favorite;
    map['like'] = like;
    map['coin'] = coin;
    map['share'] = share;
    map['createTime'] = createTime;
    map['size'] = size;
    return map;
  }

}

class Owner {
  Owner({
      this.name, 
      this.face, 
      this.fans,});

  Owner.fromJson(dynamic json) {
    name = json['name'];
    face = json['face'];
    fans = json['fans'];
  }
  String? name;
  String? face;
  int? fans;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['face'] = face;
    map['fans'] = fans;
    return map;
  }

}