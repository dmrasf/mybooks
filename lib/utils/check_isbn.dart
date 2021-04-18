bool checkIsbn(String isbnStr) {
  if (isbnStr.length != 10 && isbnStr.length != 13) return false;
  List<String> chars = isbnStr.split('');
  List<int> isbn = [];
  try {
    for (int i = 0; i < chars.length; i++) isbn.add(int.parse(chars[i]));
  } catch (_) {
    return false;
  }
  print(isbn);
  if (isbn.length != 10 && isbn.length != 13) return false;
  int sum = 0;
  if (isbn.length == 10) {
    for (int i = 0; i < isbn.length; i++) sum += (10 - i) * isbn[i];
    if (sum % 11 == 0) return true;
    return false;
  } else {
    for (int i = 0; i < isbn.length; i++)
      sum += ((13 - i).isOdd ? 1 : 3) * isbn[i];
    if (sum % 10 == 0) return true;
    return false;
  }
}
