class DelteOrAddResponseFavouriteEntity {
  DelteOrAddResponseFavouriteEntity({
    required this.status,
    required this.message,
    required this.data,
  });

  final String? status;
  final String? message;
  final List<String>? data;
}
