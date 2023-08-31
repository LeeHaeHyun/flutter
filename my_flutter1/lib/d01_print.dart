/*
  다트 언어의 출발점(entry point)은 main 메서드이다.
  플러터는 역시 여기부터 시작된다.
*/

void main()
{
  print('Hello'); // 문자열 표현식 더블쿼테이션(쌍따운표)
  print('Hello'); // 싱글 쿼테이션(홀따운표)도 가능

  int num = 1;
  print(num);
  // 변수의 값을 문자열과 같이 출력할 때는 $변수와 같이 사용한다.
  print('num의 값은 $num');

  // 수식이 있는 경우 ${수식}과 같이 사용한다.
  print('1+2=${1+2}');
}