
library page;

import 'package:js/js.dart';
import 'dart:js';

final Expando _dataExpando = new Expando<JsPathContext>();

@JS()
@anonymous
class JsPathContext {
  external String get path;
  external dynamic get params;
  external factory JsPathContext({String path, dynamic params});
}

class PathContext {
  JsPathContext _js;

  PathContext.fromJsPathContext(this._js);

  String get path => _js.path;
  dynamic get params => _js.params;

  operator [](index) {
    Map data = _dataExpando[_js];
    return data != null ? data[index] : null;
  }

  operator []=(index, value) {
    Map data = _dataExpando[_js];
    if(data != null){
      data[index] = value;
    }else {
      data = {index:value};
      _dataExpando[_js] = data;
    }
  }

}

@JS('page')
external page(path, [fn]);

@JS('page.redirect')
external redirect(src, [dst]);

@JS('page.start')
external start([options]);

/*
import 'dart:js';

typedef void Callback(context, next);

get callbacks => context['page']['callbacks'];
set callbacks(value) =>  context['page']['exits'] = value;
get exits => context['page']['callbacks'];
set exits(value) =>  context['page']['exits'] = value;

page(path, [fn]){
  if(fn is Function){
    fn = _wrapCallback(fn);
  }
  context.callMethod('page', [path, fn]);
}

redirect(path1, [path2]){

  if(path2 != null){
    context['page'].callMethod('redirect', [path1, path2]);
  }else {
    context['page'].callMethod('redirect', [path1]);
  }
}

start([options= const {}]){
  context['page'].callMethod('start', [options]);
}

_wrapCallback(fn){
  return (context, next) {
    fn(context,next);
  };
}
*/
