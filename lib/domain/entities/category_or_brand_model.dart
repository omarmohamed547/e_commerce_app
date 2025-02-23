class CategoryOrBrandRespnseEntity {
  CategoryOrBrandRespnseEntity({
    required this.results,
    required this.metadata,
    required this.data,
  });

  final int? results;
  final MetadataEntity? metadata;
  final List<DatumEntity>? data;
}

class DatumEntity {
  DatumEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  final String? id;
  final String? name;
  final String? slug;
  final String? image;
}

class MetadataEntity {
  MetadataEntity({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
  });

  final int? currentPage;
  final int? numberOfPages;
  final int? limit;
}
