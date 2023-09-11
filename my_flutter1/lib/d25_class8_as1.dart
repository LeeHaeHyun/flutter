// 다운 캐스팅 이해를 돕기 위해
class Point
{
  int? x;
  int? y;
}

class PointDetail extends Point
{
  int? z;
}

void main()
{
  PointDetail p1 = PointDetail();
  p1.x = 4; // setter
  p1.y = 5;
  p1.z = 6;
  // 자식 클래스(PointDetail)을 부모클래스(Point)로 타입 캐스팅하는 것을
  // 업캐스팅(up-casting)이라 합니다.
  // 부모타입으로 캐스팅해서 막 사용하다가 자식객체를 다시 받아야 할 때
  Point p2 = p1;
  //...

  // 다시 point detail의 z값에 접근하거나 사용해야 할 때
  if(p2 is PointDetail) // is로 판단해서 한번 확인했기 때문에 as를 생략가능//
    {
    PointDetail p3 = p2 as PointDetail; // 다운 캐스팅
    print(p3.z);
    print("oo");
    }
  else {
    print("ㄴㄴ");
  }
}