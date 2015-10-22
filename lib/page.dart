library page;

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
