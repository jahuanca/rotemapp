
import 'package:app_metor/src/utils/core/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainContentController extends GetxController{

  int currentPageIndex = 0;
  PageController pageController = PageController();
  UserPreferences userPreferences = UserPreferences();

  MainContentController();

  void changePage(int index){
    currentPageIndex = index;
    pageController.jumpToPage(index);
    update(['current_page_index']);
  }

}