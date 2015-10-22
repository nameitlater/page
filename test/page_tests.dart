@TestOn('browser')

library page.test;

import 'dart:async';
import 'dart:html';
import 'package:page/page.dart' as page;
import 'package:test/test.dart';

main(){

  var called, baseTag, base = '', html='', htmlWrapper='';

  setUp((){

    page.callbacks = [];
    page.exits = [];

    page.page('*', (context,next) {
      called = true;
    });

    if (baseTag == null) {
          baseTag = document.createElement('base');
          document.querySelector('head').append(baseTag);
        }

        baseTag.setAttribute('href', (base != '' ? base + '/' : '/'));

        htmlWrapper = document.createElement('div');

        html += '<ul class="links">';
        html += '      <li><a class="index" href="./">/</a></li>';
        html += '      <li><a class="whoop" href="#whoop">#whoop</a></li>';
        html += '      <li><a class="about" href="./about">/about</a></li>';
        html += '      <li><a class="contact" href="./contact">/contact</a></li>';
        html += '      <li><a class="contact-me" href="./contact/me">/contact/me</a></li>';
        html += '      <li><a class="not-found" href="./not-found?foo=bar">/not-found</a></li>';
        html += '</ul>';

        htmlWrapper.innerHtml = html;
        document.body.append(htmlWrapper);

        page.start();

  });

  group('on page load ', () {
      print('group');
         test('should invoke the matching callback', ()  {
           expect(called, equals(true));
         });

       });


}
