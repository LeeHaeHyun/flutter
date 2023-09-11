// 부모 클래스를 정의
class Unit {
  var health = 10;
}

// 자식 클래스 정의(Unit을 상속)
class Marine extends Unit {
  var name = '마린';
}
class Medic extends Unit {
  var name = '메딕';
}

void main()
{
  // 객체를 생성
  Marine marine = Marine();
  Medic medic = Medic();

  // marine을 unit으로 형변환
  Unit unit1 = marine as Unit; //객체의 형변환을 위해 as를 사용한다.
  Unit unit2 = medic; // 현재 버전에서는 as없이도 형변환이 가능하다.

  // if - is를 통해 확인해야만 강제형변환이 가능
  // is는 특정 타입이 맞다면, 즉 상속관계가 있으면 true를 반환한다.
  // 원래 class를 확인하는 것
  if (unit1 is Marine) {
    print('마린입니다.');
    print(unit1.name); // 자바와는 다름, 자바는 이렇게 참조가 안됨.
  }
  else {
    print('마린이 아닙니다.');
  }

  /*
      자바에서는 부모타입의 참조변수로 자식쪽 멤버변수에 접근할 수 없다.
      하지만 다트에서는 가능하다. 마치 변수까지 오버라이딩 되는 듯한 느낌
  */
  // print(unit1.name) => 단독적으로는 해당 문장은 사용할 수 없다.
  /*
    이 문장을 of문 블럭 외부로 옮기면 에러가 발생한다.
    is를 통해 부모타입을 자식타입으로 변환이 가능한지 확인한 후
    접근을 허용하게 된다.
  */
  
  // as없이 대입해도 정상적으로 출력된다.
  if(unit2 is Medic){
    print("메딕입니다.");
  }
  else{
    print('메딕이 아닙니다.');
  }
}

