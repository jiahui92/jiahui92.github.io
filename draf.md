

## BFCache
https://developer.mozilla.org/en-US/docs/Archive/Misc_top_level/Working_with_BFCache

onpageshow
	=> event.presisted && location.reload();


## 点透事件
stopImediatePropagation阻止click事件继续执行

## 弹层滚动
* 滚动中间层到底，会触发外层继续滚动；
* 增加oveflow:hidden修复完毕之后，弹出层的动作会导致，页面自动回滚到最顶部
* 继续修复：overflow:hidden之后强行使页面偏移到滚动处；结束后再恢复；

