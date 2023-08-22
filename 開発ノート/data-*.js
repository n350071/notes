// how to use data-* in javascript

// <%= link_to "do something".html_safe, do_something_path(@something), class: 'btn btn-sm btn-warning', method: :post, id: 'do_something', data: { confirm: t('messages.something.do'), target: '#something', url: great_path(@something) } %>
// => <a class="btn btn-sm btn-warning" id="do_something" data-confirm="do it now?" data-target="#something" data-url="/great/231" rel="nofollow" data-method="post" href="/something/231/do"> do something </a>

// the js
var myFunc = new MyFunction('#something');
myFunc.doAnotherthing();
myFunc.ayncStart();
