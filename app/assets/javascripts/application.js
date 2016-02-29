// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .

    function parseURL() {
        // This function is anonymous, is executed immediately and 
        // the return value is assigned to QueryString!
        var query_string = {};
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i=0;i<vars.length;i++) {
            var pair = vars[i].split("=");
            // If first entry with this name
            if (typeof query_string[pair[0]] === "undefined") {
                query_string[pair[0]] = decodeURIComponent(pair[1]);
                // If second entry with this name
            } else if (typeof query_string[pair[0]] === "string") {
                var arr = [ query_string[pair[0]],decodeURIComponent(pair[1]) ];
                query_string[pair[0]] = arr;
                // If third or later entry with this name
            } else {
                query_string[pair[0]].push(decodeURIComponent(pair[1]));
            }
        } 
        return query_string;
    }

Turbolinks.enableProgressBar();
$(document).ready( function() {
    var QueryString = parseURL();

    // returns true if the element or one of its parents has the class classname
    function hasSomeTableParentTheClass(element, classname) {
        if (element.attr('class') != undefined && element.attr('class').split(' ').indexOf(classname)>=0) return true;
        if(element.is('table') != true) 
            return element.parent() && hasSomeTableParentTheClass(element.parent(), classname);
    }

    $(".table-clickeable").on("click", "tr", function() {
        $(this).addClass('clicked')
        var url = $( this ).data("url");
    if((typeof url !== 'undefined') && (url != "")) {
        index = $(this).parent().children().index($(this));
        if(hasSomeTableParentTheClass($(this), 'table-indexable')) {
            url=url+index;
        }
        window.location= url;
    }
    });

    $(".load-more").on("click",  function() {
        $( this )[0].innerHTML = "Loading...";
        var page = QueryString.page;
        if(typeof page == 'undefined')
        page = 1;
    //$.ajax(url: window.location.href.split('?')[0]+"?page="+(parseInt(page)+1) ).done(html) {
    //$.ajax(url: "/listings/London?page=2" ).done(html) {
    //    alert(html);
    //}
    //window.location= window.location.href.split('?')[0]+"?page="+(parseInt(page)+1)
    $.ajax({
        url: window.location.pathname+"?page="+(parseInt(page)+1),
        context: document.body, 
        dataType: 'script' 
    }).done(function(html) {
    QueryString = parseURL();
        //if(typeof QueryString.page == 'undefined')
        //QueryString.page = 2;
        //else
        //QueryString.page = QueryString.page+1;
    });
    });
    });
