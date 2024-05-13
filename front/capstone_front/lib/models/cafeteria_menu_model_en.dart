class CafeteriaMenuModelEn {
  List<String> cafeteria = [
    "Hanwool Restaurant (B1F, Law Building)",
    "Student Center (Welfare Center 1F)",
    "Faculty and Staff Cafeteria (Welfare Center, 1st floor)",
    "Cheonghyang Korean Restaurant (5th floor, Law Building)",
    "Cheonghyang Form Hall (5th floor of the Law Building)",
    "Dormitory Cafeteria (Dormitory A, 1st floor)",
    "Dormitory Cafeteria (Dormitory Building A, 1st floor)",
  ];
  List<List<List<String>>> cafeteriaMenus = [];

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

  void addData(int cafeteriaIndex, var data) {
    List<List<String>> tmpList = [];
    if (cafeteriaIndex == 0) {
      addFunc(data, tmpList, "1Corner\u003Cbr\u003ESNACK1", "1Corner SNACK1");
      addFunc(data, tmpList, "1Corner\u003Cbr\u003ESNACK2", "1Corner SNACK2");
      addFunc(data, tmpList, "2Corner\u003CBR\u003ENOODLE", "2Corner NOODLE");
      addFunc(data, tmpList, "3Corner\u003Cbr\u003ECUTLET", "3Corner CUTLET");
      addFunc(
          data, tmpList, "4Corner\u003Cbr\u003ERICE.Oven", "4Corner RICE.Oven");
      addFunc(data, tmpList, "5Corner\u003Cbr\u003EGUKBAP.Chef",
          "5Corner GUKBAP.Chef");
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

  CafeteriaMenuModelEn.fromJson(List<dynamic> json, String date) {
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
  }
}
