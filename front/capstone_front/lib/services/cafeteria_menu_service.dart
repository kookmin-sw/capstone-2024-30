import 'dart:convert';

import 'package:capstone_front/models/api_fail_response.dart';
import 'package:capstone_front/models/api_success_response.dart';
import 'package:capstone_front/models/cafeteria_menu_model.dart';
import 'package:capstone_front/models/notice_model.dart';
import 'package:capstone_front/models/notice_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<CafeteriaMenuModel> getCafeteriaMenu(
    String date, String language) async {
  final String baseUrl = dotenv.get('BASE_URL');
  final url = Uri.parse('$baseUrl/menu/daily?date=$date&language=$language');
  final response = await http.get(url);

  final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));

  final Map<String, dynamic> jsonExample = {
    "success": true,
    "message": "Successfully load menus",
    "response": [
      {
        "한울식당(법학관 지하1층)": {
          "2024-05-04": {
            "5코너<br>GUKBAP.Chef": {
              "가격": "0",
              "메뉴": "[중식]\r\n부대찌개\r\n￦5000\r\n[석식]\r\n얼큰국밥\r\n￦6000"
            },
            "3코너<br>CUTLET": {"가격": "5000", "메뉴": "[중식]\r\n치킨까스"},
            "1코너<br>SNACK1": {
              "가격": "0",
              "메뉴":
                  "※학기중\r\n운영시간\r\n안내\r\n\r\n평일\r\n11시~18시30분\r\n※ 토/일요일 및 공휴일\r\n휴점"
            },
            "2코너<BR>NOODLE": {"가격": "3900", "메뉴": "[중식]\r\n바지락칼국수\r\n&손만두3"},
            "4코너<br>RICE.Oven": {
              "가격": "0",
              "메뉴": "[중식]\r\n제육파채비빔밥\r\n￦4300\r\n[중석식]\r\n소고기덮밥\r\n￦4900"
            }
          }
        }
      },
      {
        "학생식당(복지관 1층)": {
          "2024-05-04": {
            "착한아침": {
              "가격": "3500",
              "메뉴": "북어미역국\r\n기장밥/계란후라이\r\n돼지고기장조림\r\n고들빼기무침\r\n"
            },
            "인터쉐프<br>중식": {
              "가격": "5500",
              "메뉴":
                  "[금주의 추천메뉴]\r\n트윈까스SET\r\n(등심돈까스&생선까스)\r\n크림스프/후리가케밥小\r\n그린샐러드/쥬시쿨\r\n"
            },
            "데일리밥<br>중식": {"가격": "3700", "메뉴": "미트볼갈릭볶음밥\r\n\r\n그린샐러드\r\n"},
            "차이웨이<br>상시": {
              "가격": "0",
              "메뉴":
                  "찹쌀탕수육4000\r\n직화간짜장4700\r\n직화짬뽕 5500\r\n짬짜면 6700\r\n공기밥 1000\r\n"
            },
            "채식<br>중식": {
              "가격": "0",
              "메뉴": "※채식(데일리밥)코너 운영시간\r\n(매주 수요일) 11:00 ~ 선착순 100개)"
            },
            "누들송<br>중식": {"가격": "3900", "메뉴": "미소라멘\r\n\r\n쥬시쿨\r\n"},
            "천원의 아침밥": {
              "가격": "1000",
              "메뉴": "황태미역국\r\n기장밥/계란후라이\r\n돼지고기장조림\r\n고들빼기무침\r\n국민두유\r\n"
            },
            "석식Ⅰ": {
              "가격": "5000",
              "메뉴": "뚝)들깨수제비\r\n쌀밥 小\r\n야채튀김\r\n무말랭이무침\r\n"
            },
            "가마<br>중식": {
              "가격": "5000",
              "메뉴": "뚝)누룽지찜닭\r\n쌀밥\r\n단호박전\r\n오이깍뚝무침\r\n"
            },
            "석식Ⅱ": {"가격": "4800", "메뉴": "우삼겹마파두부덮밥\r\n\r\n야채튀김\r\n무말랭이무침\r\n"}
          }
        }
      },
      {
        "교직원식당(복지관 1층)": {
          "2024-05-04": {
            "키친1": {
              "가격": "7700",
              "메뉴":
                  "뚝)짬뽕순두부찌개*쫄면사리\r\n차조밥\r\n떡갈비피망조림\r\n감자채볶음\r\n브로콜리숙회\r\n저염김치\r\n"
            },
            "키친2": {
              "가격": "7700",
              "메뉴": "미나리삼겹나물비빔밥\r\n얼갈이국\r\n설탕핫도그\r\n흑임자연근무침\r\n저염김치\r\n"
            },
            "오늘의<br>샐러드": {
              "가격": "0",
              "메뉴": "양상추샐러드&삼색야채샐러드\r\n샐러드토핑2종&드레싱2종\r\n과일푸딩\r\n현미밥&숭늉\r\n"
            },
            "석식": {
              "가격": "7700",
              "메뉴":
                  "뚝)비벼먹는 고추장찌개\r\n쌀밥\r\n순살햄구이\r\n파래자반볶음\r\n도토리묵무침\r\n깍두기\r\n양상추샐러드&삼색야채샐러드\r\n식혜\r\n"
            }
          }
        }
      },
      {
        "청향 한식당(법학관 5층)": {
          "2024-05-04": {
            "메뉴1": {"가격": "10000", "메뉴": "차돌육개장"},
            "메뉴3": {"가격": "16000", "메뉴": "들기름메밀막국수와 수육정식"},
            "메뉴2": {"가격": "14000", "메뉴": "숯불주꾸미비빔밥&미니된장찌개정식"},
            "메뉴4": {"가격": "17000", "메뉴": "철판 훈제오리구이와 단호박오곡영양솥밥정식"}
          }
        }
      },
      {
        "청향 양식당(법학관 5층)": {
          "2024-05-04": {
            "STEAK": {
              "가격": "0",
              "메뉴": "채끝스테이크\r\n37,000원\r\n안심스테이크\r\n43,000원"
            },
            "파스타": {
              "가격": "0",
              "메뉴":
                  "알리오올리오 17,000원\r\n포모도로\r\n19,000원\r\n감바스알아히오\r\n19,000원\r\n까르보나라\r\n20,000원\r\n해산물토마토파스타 23,000원\r\n(NEW) 통베이컨로제파스타\r\n25,000원\r\nLA갈비오일파스타\r\n29,000원"
            },
            "리조또": {
              "가격": "0",
              "메뉴": "트러플베이컨풍기리조또\r\n20,000원\r\n아보카도부라타리조또\r\n27,000원"
            }
          }
        }
      },
      {
        "생활관식당 일반식(생활관 A동 1층)": {
          "2024-05-04": {
            "중식": {
              "가격": "7700",
              "메뉴":
                  "깻잎간장제육\r\n\r\n수수밥\r\n두부김칫국\r\n꼬시래기곤약무침\r\n멸치볶음\r\n유자무생채\r\n열무김치\r\n매실주스\r\n\"♥비빔 DIY코너♥\r\n(김가루,고추장,참기름)\"\r\n"
            }
          }
        }
      },
      {
        "생활관식당 정기식(생활관 A동 1층)": {
          "2024-05-04": {
            "석식": {
              "가격": "0",
              "메뉴":
                  "하이라이스정식\r\n\r\n미소시루\r\n함박까스&소스2종\r\n양배추샐러드*드레싱\r\n깍두기\r\n요구르트\r\n"
            }
          }
        }
      },
      {
        "K-Bob<sup>+</sup>": {
          "2024-05-04": {
            "사전주문안내": {"가격": "0", "메뉴": "*회의 및 행사용 도시락의 경우 3일전 주문 필수"},
            "오늘의도시락": {"가격": "0", "메뉴": "※운영시간\r\n11시~17시\r\n\r\n※주말 및 공휴일 휴점"},
            "간편도시락": {
              "가격": "0",
              "메뉴":
                  "통스팸김치덮밥\r\n￦6500\r\n돈가스마요덮밥\r\n￦7500\r\n핵불닭덮밥\r\n￦7500\r\n참치비빔밥\r\n￦6500\r\n삼겹살비빔밥\r\n￦7900\r\n육회비빔밥\r\n￦7700\r\n(특)육회비빔밥\r\n￦10000\r\n치즈부대찌개\r\n￦7900\r\n치즈스팸부대찌개\r\n￦9000\r\n대패삼겹도시락\r\n￦10000\r\n항정살도시락\r\n￦11500\r\n가브리살도시락\r\n￦11500"
            }
          }
        }
      }
    ]
  };
  // return CafeteriaMenuModel.fromJson(jsonExample['response'], date);
  if (response.statusCode == 200) {
    return CafeteriaMenuModel.fromJson(json['response'], date);
    // return CafeteriaMenuModel.fromJson(jsonExample['response'], date);
  } else {
    var apiFailResponse = ApiFailResponse.fromJson(json);
    print('Request failed with status: ${response.statusCode}.');
    print(apiFailResponse.message);
    throw Exception('Failed to load notices');
  }
}
