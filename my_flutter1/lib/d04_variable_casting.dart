void main()
{
  int num1 = 1;
  print('num1 : $num1');

  double num2 = 2.0;
  print('num2-1 : $num2');

  double num3 = 2.1;
  print('num2-2 : $num3');

  /*
    Java의 경우 double보다 int형이 작은 자료형이므로 아래의 경우
    오토캐스팅 되어 에러가 발생하지 않습니다.
    하지만, flutter에서는 모든 변수를 객체로 인식하므로
    명시적인 형변환을 해야 한다.
  */
  // num3 = num1; // 오토캐스팅이 안된다. 자동 형변환이 안됨
  // 명시적인 형변환이 필요하다. ToDouble같은 메소드를 통한 형변환을 해야한다
  num3 = num1.toDouble(); 
  print('num3 : $num3');

  num2 = 2.6;
  num1 = num2.toInt(); // 소수점 이해 절삭
  print('num1 : $num1');
  /*
      Java의 레퍼클래스처럼 형변환을 위한 메소드를 가지고 있다.
  */
}