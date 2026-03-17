class MoreMovieArgs {
  final String category;
  final String title;
  final bool isTopTen;
  final bool isTVShow;

  MoreMovieArgs({required this.category, required this.title , this.isTopTen = false , this.isTVShow = false});
}