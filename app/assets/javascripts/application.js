// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery
//
//= require rails-ujs
//= require bxslider
//= require activestorage
//= require turbolinks
//= require_tree .
/*global $*/
//topヘッダーから指定位置までスクロール
$(function () {
    $('a[href^="#"]').click(function () {
        var speed = 500;
        var href= $(this).attr("href");
        var target = $(href == "#" || href == "" ? 'html' : href);
        var position = target.offset().top;
        $("html, body").animate({scrollTop:position}, speed, 'swing');
        return false;
    });
});
//ページ上部（top）へスクロール
$(function() {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 800);
    event.preventDefault();
  });
});
//top画像スクロール
$(document).on('turbolinks:load', function(){
  $('.bxslider').bxSlider({
    auto: true,           // 自動スライド
    speed: 1000,          // スライドするスピード
    moveSlides: 1,        // 移動するスライド数
    pause: 3000,          // 自動スライドの待ち時間
    maxSlides: 1,         // 一度に表示させる最大数
    randomStart: true,    // 最初に表示するスライドをランダムに設定
    responsive: true,     //レスポンシブ対応
    wrapperClass: 'bx-wrapper',//bx-weapperにクラス付与
    autoHover: true       // ホバー時に自動スライドを停止
  });
});

// チャットメッセージをスクロール表示
// $(window).on('scroll', function() {
//   var scrollHeight = $(document).height();
//   var scrollPosition = $(window).height() + $(window).scrollTop();
//   if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
//     $('.jscroll').jscroll({
//       contentSelector: '.message',
//       nextSelector: 'span.next:last a'
//     });
//   }
// });
