void main()
{
  // 메서드도 변수에 대입이 가능
  // Dart에서는 메소드를 객체로 취급하기 때문
  var myFunc = addTwoNum;

  // 변수를 이용하여 메소드 호출 : 메서드명의 리네임 같다.
  myFunc(1, 2);

  // 메서드 파라미터에 메서드를 사용
  something("2", "3", myFunc);
}

void addTwoNum(int a, int b) {
  print(a + b);
}

void something(var a, var b, var c) {
  int val1 = int.parse(a);
  int val2 = int.parse(b);

  // c는 메소드이므로..
  c(val1, val2);
}