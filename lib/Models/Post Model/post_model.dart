

class PostModel
{
  String? name;
  String? uId;
  String? image;
  String? dataTime;
  String? text;
  String? postImage;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dataTime,
    this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic>json)
  {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dataTime = json['dataTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap()
  {
    return
      {
        'name' : name,
        'uId' : uId,
        'image' : image,
        'dataTime' : dataTime,
        'text' : text,
        'postImage' : postImage,
      };
  }
}