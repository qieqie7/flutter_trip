main(List<String> args) {
  print(a(null));
}

String a(bool isTrue) {
  if(isTrue == null) {
    return 'null';
  }
  return isTrue ? '1' : '2';
}