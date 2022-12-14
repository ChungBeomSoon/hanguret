// output
// (id에 해당하는 식당정보)
//
// {
// id:식당고유id(String),
//kakaoId: 식당의kakaoId(String),
// name: 식당의 이름(String),
// icon: 식당의 icon 번호(Int),
// detail: 식당 한줄소개(String),
// score: 식당의 평균평점(double),
// address: 식당의 주소(String),
// distance: 식당과 사용자 사이의 거리
// myReview: {date, score, image, icon, likes}현사용자가 남긴 해당 식당리뷰(없으면 null)
// }

// input
// {
// resId:식당고유id(String),
// userId: 사용자 id(String),
// location: 사용자의 현위치
// }

//사람들 눌렀을 때,
//input
//{resId}
//
//output
//{
//userName,
//date,
//score,
//image,
//like(int),
//icon(int)
//}[]

//내 리뷰 있는 버전
const resDetailOutputMy3 = {
  "id": "3",
  "kakaoId": null,
  "name": "리피토리아",
  "category1": 0,
  "tag1": "분위기",
  "detail": "파스타와 스테이크를 한번에",
  "score": "4.5",
  "address": "서울 서대문구 연세로4길 62",
  "distance": 300,
  "imgUrl": "images/restaurants/3.jpg",
  "myReview": {
    "reviewId": "12",
    "date": "2022년 5월 2일",
    "score": 3,
    "imgUrl": "images/restaurants/3_2.jpg",
    "category": 0, // 사용자가 리뷰할 때 선택한 카테고리 (0:밥, 1: 술, 2:카페)
    "icon": "기름칠", // 수정부분) tag-> icon으로 항목이름 변경
    "likes": 100,
    "liked": true, //현 사용자가 좋아요를 누른 리뷰인지?
  },
};

//내 리뷰 없는 버전
const resDetailOutputMy4 = {
  "id": "4",
  "kakaoId": "1948873687",
  "name": "라플로레종",
  "category1": 2,
  "tag1": "디저트",
  "tag2": "분위기",
  "detail": "디저트 so 맛있어요",
  "score": "4.5",
  "address": "서울 서대문구 연세로4길 62",
  "distance": 300,
  "myReview": null,
  "imgUrl": "images/restaurants/4.jpg",
};

const resDetailOutputAll3 = [
  {
    "reviewId": "11",
    "userId": "kakao:2204160870",
    "userName": "건협",
    "date": "2022년 5월 2일",
    "score": 3,
    "imgUrl": "images/restaurants/3_2.jpg",
    "category": 0, //수정부분) 카테고리 항목 추가
    "icon": "분위기",
    "likes": 50,
    "liked": true,
  },
  {
    "reviewId": "14",
    "userId": "kakao:2363915906",
    "userName": "수빈",
    "date": "2022년 5월 2일",
    "score": 3,
    "imgUrl": "images/restaurants/3_2.jpg",
    "category": 0, //수정부분) 카테고리 항목 추가
    "icon": "분위기",
    "likes": 50,
    "liked": true,
  },
  {
    "reviewId": "15",
    "userId": "kakao:2318981232",
    "userName": "다은",
    "date": "2022년 5월 1일",
    "score": 4,
    "imgUrl": "images/restaurants/4.jpg",
    "category": 0,
    "icon": "기름칠",
    "likes": 40,
    "liked": false,
  },
  {
    "reviewId": "16",
    "userId": "kakao:2363915906",
    "userName": "수빈",
    "date": "2022년 5월 2일",
    "score": 3,
    "imgUrl": "images/restaurants/3.jpg",
    "category": 0,
    "icon": "분위기",
    "likes": 50,
    "liked": false,
  },
  {
    "reviewId": "17",
    "userId": "kakao:2318981232",
    "userName": "다은",
    "date": "2022년 5월 1일",
    "score": 4,
    "imgUrl": "images/restaurants/3_2.jpg",
    "category": 0,
    "icon": "기름칠",
    "likes": 40,
    "liked": false,
  },
  {
    "reviewId": "18",
    "userId": "kakao:2363915906",
    "userName": "수빈",
    "date": "2022년 5월 2일",
    "score": 3,
    "imgUrl": "images/restaurants/3_2.jpg",
    "category": 0,
    "icon": "분위기",
    "likes": 50,
    "liked": false,
  },
  {
    "reviewId": "19",
    "userId": "kakao:2318981232",
    "userName": "다은",
    "date": "2022년 5월 1일",
    "score": 4,
    "imgUrl": "images/restaurants/3_2.jpg",
    "category": 0,
    "icon": "기름칠",
    "likes": 40,
    "liked": false
  },
  {
    "reviewId": "20",
    "userId": "kakao:2363915906",
    "userName": "수빈",
    "date": "2022년 5월 2일",
    "score": 3,
    "imgUrl": "images/restaurants/3_2.jpg",
    "category": 0,
    "icon": "분위기",
    "likes": 50,
    "liked": false,
  },
  {
    "reviewId": "21",
    "userId": "kakao:2318981232",
    "userName": "다은",
    "date": "2022년 5월 1일",
    "score": 4,
    "imgUrl": "images/restaurants/3_2.jpg",
    "category": 0,
    "icon": "기름칠",
    "likes": 40,
    "liked": false,
  },
  {
    "reviewId": "22",
    "userId": "kakao:2363915906",
    "userName": "수빈",
    "date": "2022년 5월 2일",
    "score": 3,
    "imgUrl": "images/restaurants/3_2.jpg",
    "category": 0,
    "icon": "분위기",
    "likes": 50,
    "liked": false,
  },
  {
    "reviewId": "23",
    "userId": "kakao:2318981232",
    "userName": "다은",
    "date": "2022년 5월 1일",
    "score": 4,
    "imgUrl": "images/restaurants/3_2.jpg",
    "category": 0,
    "icon": "기름칠",
    "likes": 40,
    "liked": false,
  },
];
