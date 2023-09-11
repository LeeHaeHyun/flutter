void main()
{
  // Nullable & Non-Nullable
  int num1 = 5;   // null값을 허용하지 않는 변수로 선언
  int? num2 = 2;   // null값을 허용하는 변수. 값이 없으면 null

  // num1 = null; // 에러 발생 : Non-Nullable
  num2 = null; // ok : Nullable

  // String str1 = null; // error : Non-Nullable
  String? str2 = null;    // ok : Nullable

  print("1 ========================================================");

  // Null Safety 규칙 null일때 안전하게 사용하기 위해

  // Non-Nullable 변수는 값 대입 없이 사용할 때 error
  // int a1; print(a1); 에러 발생
  int? a2; print(a2);

  // a2변수는 Nullable. 선언과 동시에 초기값이 null이 대입되어 초기화된다.
  // a1은 Non-Nullable. null로 자동 초기화 할 수 없다.

  // var 타입에서의 Null Safety
  // int 타입으로 유추. Non-Nullable 변수임으로 null 대입 불가능
  var a3 = 10;
  var a4 = null; // dynamic으로 유추
  var a5;     // dynamic으로 유추
  // var? a6 = null; // error

  // var로 타입 선언시 Nullable과 Non-Nullable로 자동 유추가 된다.
  // var 타입 뒤에는 ?를 추가할 수 없다.

  print("2 =========================================================");

  // Nill safety Operator

  int num3 = 5;
  int? num4;

  // ! : null check operator - runtime error throw
  // 변수 뒤에 !을 추가하면 이 변수 값이 null 인 경우 runtime error 발생

  num4 = 10; // 이 줄이 없으면 다음줄 에러
  num3 = num4; // 컴파일 전 체크
  // num3 = num4!;   // 실행시 체크


  // ?, ?[ ] ?.. - Null aware operator
  // String name;  // <-- 값이 대입되지 않고 사용되면 null일 수 있다.
  String? name;

  // Null이 아닐 때 메서드 실행
  // ?를 제거하면 에러발생됨. 객체가 null인 상태에서는 멤버메서드를 호출
  // 할 수 없기 때문이다.
  name = name?.toLowerCase();

  // Null 일 때
  // n42는 정수가 아니므로 정수로 변환시 에러 발생됨. 따라서 val2는 -1로 초기화된다.
  int val2 = int.tryParse('n42') ?? -1;
  print('val2 = $val2');

  String? name1;
  name1 = 'sssss'; // 이 값이 없으면 런타임 에러가 난다
    // String text = name1; // 에러가 떴을때 어떻게 해야 할까?
    // 변수 뒤에 !를 붙여주면 된다. 그러면 flutter는 변수가 사용되는 시점에서
    // null값이 절대 아님을 알 수 있다. 그러면서 에러를 없애줄 수 있다.
    String text = name1!;
    print(text);

}