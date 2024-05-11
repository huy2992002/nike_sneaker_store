abstract class SearchEvent {}

class SearchTextChanged extends SearchEvent {
  SearchTextChanged({required this.searchText});

  final String searchText;
}

class RemoveTextPressed extends SearchEvent {}
