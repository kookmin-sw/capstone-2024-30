class CafeteriaMenuModel {
  List<List<List<String>>> cafeteriaMenus = [];
  List<String> cafeteriaKo = [
    "한울식당(법학관 지하1층)",
    "학생식당(복지관 1층)",
    "교직원식당(복지관 1층)",
    "청향 한식당(법학관 5층)",
    "청향 양식당(법학관 5층)",
    "생활관식당 일반식(생활관 A동 1층)",
    "생활관식당 정기식(생활관 A동 1층)",
  ];
  List<String> cafeteriaEn = [
    "Hanwool Restaurant (B1F, Law Building)",
    "Student Center (Welfare Center 1F)",
    "Faculty and Staff Cafeteria (Welfare Center, 1st floor)",
    "Cheonghyang Korean Restaurant (5th floor, Law Building)",
    "Cheonghyang Form Hall (5th floor of the Law Building)",
    "Dormitory Cafeteria (Dormitory A, 1st floor)",
    "Dormitory Cafeteria (Dormitory Building A, 1st floor)",
  ];

  void addFunc(
      var data, List<List<String>> targetList, String type, String addName) {
    if (data != null && data[type] != null) {
      String tmpMenu = data[type]["메뉴"];
      // menu
      tmpMenu = tmpMenu.replaceAll('\r\n', ' ');
      // ※가 2번 나오면 줄바꿈
      int tmp1 = 0;
      // []가 2번 이상 나오면 줄바꿈
      int tmp2 = 0;
      for (int i = 0; i < tmpMenu.length; i++) {
        if (tmpMenu[i] == '※') {
          tmp1 += 1;
          if (tmp1 == 1) {
            tmpMenu =
                '${tmpMenu.substring(0, i + 1)} ${tmpMenu.substring(i + 1)}';
          }
        } else if (tmpMenu[i] == '[') {
          tmp2 += 1;
          if (tmp2 >= 2) {
            tmpMenu = '${tmpMenu.substring(0, i)}\n${tmpMenu.substring(i)}';
            i += 2;
          }
        } else if (tmpMenu[i] == 'ï') {
          tmpMenu = '${tmpMenu.substring(0, i)}${tmpMenu.substring(i + 3)}';
          i += 2;
        }
        if (tmp1 == 2) {
          tmp1 = 0;
          tmpMenu =
              '${tmpMenu.substring(0, i + 1)}\n${tmpMenu.substring(i + 2)}';
        }
      }
      targetList.add([addName, tmpMenu, data[type]["가격"]]);
    }
  }

  void addDataKo(int cafeteriaIndex, var data) {
    List<List<String>> tmpList = [];
    if (cafeteriaIndex == 0) {
      addFunc(data, tmpList, "1코너<br>SNACK1", "1코너 SNACK1");
      addFunc(data, tmpList, "1코너<br>SNACK2", "1코너 SNACK2");
      addFunc(data, tmpList, "2코너<BR>NOODLE", "2코너 NOODLE");
      addFunc(data, tmpList, "3코너<br>CUTLET", "3코너 CUTLET");
      addFunc(data, tmpList, "4코너<br>RICE.Oven", "4코너 RICE.Oven");
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
        tmpList.add(["석식", data["석식"]["메뉴"], "정기식 신청자 한정"]);
      }
    }
    cafeteriaMenus.add(tmpList);
  }

  void addDataEn(int cafeteriaIndex, var data) {
    List<List<String>> tmpList = [];
    if (cafeteriaIndex == 0) {
      addFunc(data, tmpList, "1Corner\u003Cbr\u003ESNACK1", "Corner1 SNACK1");
      addFunc(data, tmpList, "1Corner\u003Cbr\u003ESNACK2", "Corner1 SNACK2");
      addFunc(data, tmpList, "2Corner\u003CBR\u003ENOODLE", "Corner2 NOODLE");
      addFunc(data, tmpList, "3Corner\u003Cbr\u003ECUTLET", "Corner3 CUTLET");
      addFunc(
          data, tmpList, "4Corner\u003Cbr\u003ERICE.Oven", "Corner4 RICE.Oven");
      addFunc(data, tmpList, "5Corner\u003Cbr\u003EGUKBAP.Chef",
          "Corner5 GUKBAP.Chef");
    } else if (cafeteriaIndex == 1) {
      addFunc(data, tmpList, "Good Morning", "Good Morning");
      addFunc(data, tmpList, "Breakfast for a Thousand",
          "Breakfast for a Thousand");
      addFunc(data, tmpList, "Kiln\u003Cbr\u003ELunch", "Kama lunch");
      addFunc(
          data, tmpList, "Daily Meals\u003Cbr\u003ELunch", "DailyBop Lunch");
      addFunc(
          data, tmpList, "Vegetarian\u003Cbr\u003EMedium", "Vegiterian Lunch");
      addFunc(data, tmpList, "InterChef\u003Cbr\u003ELunch", "InterChef Lunch");
      addFunc(
          data, tmpList, "Noodlesong\u003Cbr\u003ELunch", "NoodleSong Lunch");
      addFunc(data, tmpList, "Dinner I", "Dinner Ⅰ");
      addFunc(data, tmpList, "Dinner II", "Dinner Ⅱ");
    } else if (cafeteriaIndex == 2) {
      addFunc(data, tmpList, "Kitchen1", "Kitchen1");
      addFunc(data, tmpList, "Kitchen2", "Kitchen2");
      addFunc(data, tmpList, "Today's\u003Cbr\u003ESalad", "Today's Salad");
      addFunc(data, tmpList, "Dinner", "Dinner");
    } else if (cafeteriaIndex == 3) {
      addFunc(data, tmpList, "Menu1", "Menu1");
      addFunc(data, tmpList, "Menu2", "Menu2");
      addFunc(data, tmpList, "Menu3", "Menu3");
      addFunc(data, tmpList, "Menu4", "Menu4");
    } else if (cafeteriaIndex == 4) {
      addFunc(data, tmpList, "PASTA", "PASTA");
      addFunc(data, tmpList, "RICE", "RISOTTO");
      addFunc(data, tmpList, "STEAK", "STEAK");
    } else if (cafeteriaIndex == 5) {
      addFunc(data, tmpList, "Lunch", "Lunch");
    } else if (cafeteriaIndex == 6) {
      if (data != null && data["Dinner"] != null) {
        tmpList.add(["Dinner", data["Dinner"]["메뉴"], "Applicants only"]);
      }
    }
    cafeteriaMenus.add(tmpList);
  }

  CafeteriaMenuModel.fromJson(
      List<dynamic> json, String date, String language) {
    if (language == 'KO') {
      for (int i = 0; i < cafeteriaKo.length; i++) {
        bool dataAdded = false;
        for (int j = 0; j < json.length; j++) {
          if (json[j][cafeteriaKo[i]] != null) {
            addDataKo(i, json[j][cafeteriaKo[i]][date]);
            dataAdded = true;
            break;
          }
        }
        if (!dataAdded) {
          cafeteriaMenus.add([]);
        }
      }
    } else if (language == 'EN-US') {
      for (int i = 0; i < cafeteriaEn.length; i++) {
        bool dataAdded = false;
        for (int j = 0; j < json.length; j++) {
          if (json[j][cafeteriaEn[i]] != null) {
            addDataEn(i, json[j][cafeteriaEn[i]][date]);
            dataAdded = true;
            break;
          }
        }
        if (!dataAdded) {
          cafeteriaMenus.add([]);
        }
      }
    }
  }
}
