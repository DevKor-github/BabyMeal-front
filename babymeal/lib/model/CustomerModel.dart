class Customer {
  final String customerName;
  final String rank;
  final int myLikes;
  final int myComments;
  final int myPosts;

  Customer({
    required this.customerName,
    required this.rank,
    required this.myLikes,
    required this.myComments,
    required this.myPosts,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerName: json['customerName'],
      rank: json['rank'],
      myLikes: json['myLikes'],
      myComments: json['myComments'],
      myPosts: json['myPosts'],
    );
  }
}
