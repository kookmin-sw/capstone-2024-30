class CafeteriaMenuModel {
  List<String> cafeteria = [
    "한울식당(법학관 지하1층)",
    "학생식당(복지관 1층)",
    "교직원식당(복지관 1층)",
    "청향 한식당(법학관 5층)",
    "청향 양식당(법학관 5층)",
    "생활관식당 일반식(생활관 A동 1층)",
    "생활관식당 정기식(생활관 A동 1층)",
  ];
  List<List<List<String>>> cafeteriaMenus = [];

  void addFunc(
      var data, List<List<String>> targetList, String type, String addName) {
    if (data != null && data[type] != null) {
      targetList.add([addName, data[type]["메뉴"], data[type]["가격"]]);
    }
  }

  void addData(int cafeteriaIndex, var data) {
    List<List<String>> tmpList = [];
    if (cafeteriaIndex == 0) {
      addFunc(data, tmpList, "1코너<br>SNACK1", "1코너 SNACK1");
      addFunc(data, tmpList, "1코너<br>SNACK2", "1코너 SNACK2");
      addFunc(data, tmpList, "2코너<BR>NOODLE", "2코너 NOODLE");
      addFunc(data, tmpList, "3코너<br>CUTLET", "3코너 CUTLET");
      addFunc(data, tmpList, "4코너<br>ROCE.Oven", "4코너 RICE.Oven");
      addFunc(data, tmpList, "5코너<br>GUKBAP.Chef", "5코너 GUKBAP.Chef");
    } else if (cafeteriaIndex == 1) {
      addFunc(data, tmpList, "착한아침", "착한아침");
      addFunc(data, tmpList, "천원의 아침밥", "천원의 아침밥");
      addFunc(data, tmpList, "가마<br>중식", "가마 중식");
      addFunc(data, tmpList, "데일리밥<br>중식", "데일리밥 중식");
      addFunc(data, tmpList, "채식<br>중식", "채식 중식");
      addFunc(data, tmpList, "인터쉐프<br>중식", "인터쉐프 중식");
      addFunc(data, tmpList, "누들송<br>중식", "누들송 중식");
      addFunc(data, tmpList, "석식Ⅰ", "석식Ⅰ");
      addFunc(data, tmpList, "석식Ⅱ", "석식Ⅱ");
    } else if (cafeteriaIndex == 2) {
      addFunc(data, tmpList, "키친1", "키친1");
      addFunc(data, tmpList, "키친2", "키친2");
      addFunc(data, tmpList, "오늘의<br>샐러드", "오늘의 샐러드");
      addFunc(data, tmpList, "석식", "석식");
    } else if (cafeteriaIndex == 3) {
      addFunc(data, tmpList, "메뉴1", "메뉴1");
      addFunc(data, tmpList, "메뉴2", "메뉴2");
      addFunc(data, tmpList, "메뉴3", "메뉴3");
      addFunc(data, tmpList, "메뉴4", "메뉴4");
    } else if (cafeteriaIndex == 4) {
      addFunc(data, tmpList, "파스타", "PASTA");
      addFunc(data, tmpList, "리조또", "RISOTTO");
      addFunc(data, tmpList, "STEAK", "STEAK");
    } else if (cafeteriaIndex == 5) {
      addFunc(data, tmpList, "중식", "중식");
    } else if (cafeteriaIndex == 6) {
      if (data != null && data["석식"] != null) {
        tmpList.add(["생활관식당 정기식", data["석식"]["메뉴"], "정기식 신청자 한정"]);
      }
    }
    cafeteriaMenus.add(tmpList);
  }

  CafeteriaMenuModel.fromJson(List<dynamic> json, String date) {
    for (int i = 0; i < cafeteria.length; i++) {
      bool dataAdded = false;
      for (int j = 0; j < json.length; j++) {
        if (json[j][cafeteria[i]] != null) {
          addData(i, json[j][cafeteria[i]][date]);
          dataAdded = true;
          break;
        }
      }
      if (!dataAdded) {
        cafeteriaMenus.add([]);
      }
    }
    print(cafeteriaMenus.length);
    print(cafeteriaMenus[6]);
  }
}
