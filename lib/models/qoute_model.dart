// class QuoteList {
//   final List<Quotes> quotes;
//
//   QuoteList({this.quotes});
//   factory QuoteList.fromJson(List<dynamic> parsedJson) {
//     List<Quotes> quotes = [];
//
//     return QuoteList(
//       quotes: quotes,
//     );
//   }
// }

class Quotes {
  String text;
  String author;
  int id;

  Quotes({this.text, this.author, this.id});

  factory Quotes.fromJson(Map<String, dynamic> json) {
    return Quotes(
      text: json['text'],
      id: json['id'],
      author: json['author'].toString(),
    );
  }
}
