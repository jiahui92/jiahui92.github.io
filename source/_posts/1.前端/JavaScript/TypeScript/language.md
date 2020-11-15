---
title: 语法
toc: true
date: 2020-11-15 00:00:03
tags:
---

# TODO
* TS的内置基础类型: Omit之类的
  

# 基础类型关键字
* number, string, boolean
* any, void, never ( null, undefined )

# 语法
```typescript
export interface ISomeProps {
  message?: string,
  readonly type: string.

  onClose: () => void,
  getContainer: () => HTMLElement,
}

const arr: number[] = [1, 2];
const arr: Array<number|string> = [1, 2, '3'];

function hello(): void {}
```

## 范型
```typescript
// 注册一个范型变量T来表示用户的输入
function log<T>(a: T): T[] {
  return [a];
}
```

```typescript
// 一个稍微复杂的例子 https://github.com/ant-design/ant-design/blob/master/components/select/index.tsx#L35

type SelectValue = '0' | '1';
interface InternalSelectProps<VT> {}

interface SelectProps<VT>
  extends Omit<
    InternamSelectProps<VT>,
    'inputIcon' | 'mode' | 'xxx'
  > {
    mode?: 'multiple' | 'tags'
}

class Select<ValueType extends SelectValue>
  extends React.Component<SelectProps<ValueType>>
{}
```

# 问题
## type和interface的区别
[参考资料](https://juejin.im/post/6844903749501059085)
