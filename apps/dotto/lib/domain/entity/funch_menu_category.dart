enum FunchMenuCategory {
  set([1, 7, 8]),
  donCurry([4, 5]),
  noodle([11]),
  sideDish([2, 9]),
  dessert([3]);

  new(this.categoryIds);
  final List<int> categoryIds;
}
