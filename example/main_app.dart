// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@HtmlImport('main_app.html')
import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:logging/logging.dart';
import 'package:page/page.dart' as page;
import 'package:js/js.dart';
import 'dart:js';



@PolymerRegister('main-app')
class MainApp extends PolymerElement {

  factory MainApp() => new Element.tag('main-app');
  MainApp.created() : super.created();

  @property
  String place = '';


  final Logger _log = new Logger('MainApp');

  ready(){
    hierarchicalLoggingEnabled = true;
    Logger.root.level = Level.ALL;
    _log.level = Level.FINE;

    Logger.root.onRecord.listen(_handleLogRecord);
    page.page('*',allowInterop(_logRequest));
    page.page('/home',allowInterop(_showHome));
    page.page('/other',allowInterop(_showOther));

    page.start();
  }

  _handleLogRecord(LogRecord rec){
    print('${rec.loggerName} ${rec.level.name}: ${rec.time}: ${rec.message}');
  }



  _logRequest(context, next){
     context = new page.PathContext.fromJsPathContext(context);
     context['data'] = 'hello world';
    _log.info('Path change ${context.path} ${next.runtimeType}');
    next();
  }



  _showHome(context,next){
    context = new page.PathContext.fromJsPathContext(context);
    print('data ${context['data']}');
    set('place', 'home');
  }


  _showOther(context,next){
    set('place','other');
  }

  @reflectable
  bool checkPlace(first, second){
    return first == second;
  }

  @reflectable
  goToHome(e, o){
    _log.info('goToHome');
    page.page('/home');
  }

  @reflectable
  goToOther(e, o){
    _log.info('goToOther');
    page.page('/other');
  }


}
