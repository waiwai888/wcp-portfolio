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
// 通知タブ機能
document.addEventListener("turbolinks:load", function() {
  $('#tab-contents .tab[id != "tab1"]').hide();
  $('#tab-menu a').on('click', function(event) {
    $("#tab-contents .tab").hide();
    $("#tab-menu .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });
})


 $(function () {
      $(document).ready(function() {
          $("#notice-box").fadeOut(2000);
      });
  });
