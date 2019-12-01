
class Owner {

  int reputation;
  int userId;
  String userType;
  String profileImage;
  String displayName;
  String link;

	Owner.fromJsonMap(Map<String, dynamic> map): 
		reputation = map["reputation"],
		userId = map["user_id"],
		userType = map["user_type"],
		profileImage = map["profile_image"],
		displayName = map["display_name"],
		link = map["link"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['reputation'] = reputation;
		data['user_id'] = userId;
		data['user_type'] = userType;
		data['profile_image'] = profileImage;
		data['display_name'] = displayName;
		data['link'] = link;
		return data;
	}
}
